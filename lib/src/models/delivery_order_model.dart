import 'dart:convert';
import 'package:http/http.dart' as http;

class DeliveryOrder {
  final String id;
  final double price;
  final String guaranteedLabel;
  final double distance;
  final String deliveryTime;
  final String pickupItem;
  final String dropoffLabel;

  DeliveryOrder({
    required this.id,
    required this.price,
    required this.guaranteedLabel,
    required this.distance,
    required this.deliveryTime,
    required this.pickupItem,
    required this.dropoffLabel,
  });

  // Factory to parse socket data and calculate distance/delivery time
  static Future<DeliveryOrder> fromSocketData(
    Map<String, dynamic> orderData,
    Map<String, dynamic> restaurantData,
  ) async {
    String id = orderData['_id'] as String;

    // Convert total_price from cents to dollars
    double price =
        (orderData['total_price'] is int
            ? orderData['total_price'].toDouble()
            : orderData['total_price']) /
        100;

    // Extract restaurant and customer coordinates
    final restaurantCoords =
        restaurantData['restaurantCoords'] as List<dynamic>;
    final customerCoords =
        orderData['addresses']['coordinates']['coordinates'] as List<dynamic>;

    // Coordinates for the API request
    final origin = '${restaurantCoords[1]},${restaurantCoords[0]}'; // lat,lng
    final destination = '${customerCoords[1]},${customerCoords[0]}'; // lat,lng

    // Call Google Distance Matrix API
    double distance = 1.2; // Default placeholder
    String deliveryTime = "Deliver by 2:38 PM"; // Default placeholder
    // try {
    //   const apiKey =
    //       'AIzaSyCymvinSQuyFmmG-HrqlRiptGwrRSIp8aY'; // Replace with your Google API key
    //   final url = Uri.parse(
    //     'https://maps.googleapis.com/maps/api/distancematrix/json'
    //     '?origins=$origin'
    //     '&destinations=$destination'
    //     '&units=imperial' // Use miles for distance
    //     '&key=${apiKey}',
    //   );

    //   final response = await http.get(url);
    //   if (response.statusCode == 200) {
    //     final data = jsonDecode(response.body) as Map<String, dynamic>;
    //     if (data['status'] == 'OK') {
    //       final element = data['rows'][0]['elements'][0];
    //       if (element['status'] == 'OK') {
    //         // Extract distance in miles
    //         distance =
    //             (element['distance']['value'] /
    //                 1609.34); // Convert meters to miles

    //         // Extract duration in seconds
    //         final durationSeconds = element['duration']['value'] as int;

    //         // Calculate delivery time (current time + duration)
    //         final now = DateTime.now();
    //         final deliveryDateTime = now.add(
    //           Duration(seconds: durationSeconds),
    //         );
    //         deliveryTime = "Deliver by ${_formatTime(deliveryDateTime)}";
    //       }
    //     }
    //   }
    // } catch (e) {
    //   print('Error calling Google Distance Matrix API: $e');
    //   // Fallback to placeholders if the API call fails
    // }

    // Use restaurant name as the pickup item
    String pickupItem = restaurantData['name'] as String;

    return DeliveryOrder(
      id: id,
      price: price,
      guaranteedLabel: "Guaranteed",
      distance: distance,
      deliveryTime: deliveryTime,
      pickupItem: pickupItem,
      dropoffLabel: "Customer Dropoff",
    );
  }

  // Helper to format time as "H:MM AM/PM"
  static String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
}
