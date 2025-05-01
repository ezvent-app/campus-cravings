import 'dart:convert';
import 'package:http/http.dart' as http;

class DeliveryOrder {
  final String id;
  final double price;
  final String guaranteedLabel;
  final double distance;
  final String deliveryTime; // Display string
  final String pickupItem;
  final String dropoffLabel;

  // ✅ New field for API usage (duration in minutes)
  final int deliveryDurationInMinutes;

  DeliveryOrder({
    required this.id,
    required this.price,
    required this.guaranteedLabel,
    required this.distance,
    required this.deliveryTime,
    required this.pickupItem,
    required this.dropoffLabel,
    required this.deliveryDurationInMinutes,
  });

  static Future<DeliveryOrder> fromSocketData(
    Map<String, dynamic> orderData,
    Map<String, dynamic> restaurantData,
  ) async {
    String id = orderData['_id'] as String;

    double price =
        (orderData['total_price'] is int
            ? orderData['total_price'].toDouble()
            : orderData['total_price']) /
        100;

    final restaurantCoords =
        restaurantData['restaurantCoords'] as List<dynamic>;
    final customerCoords =
        orderData['addresses']['coordinates']['coordinates'] as List<dynamic>;

    final origin = '${restaurantCoords[1]},${restaurantCoords[0]}';
    final destination = '${customerCoords[1]},${customerCoords[0]}';

    double distance = 1.2;
    String deliveryTime = "Deliver by 2:38 PM";
    int deliveryDurationInMinutes = 30;

    try {
      const apiKey =
          'AIzaSyCymvinSQuyFmmG-HrqlRiptGwrRSIp8aY'; // Replace with your API key
      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/distancematrix/json'
        '?origins=$origin'
        '&destinations=$destination'
        '&units=imperial'
        '&key=$apiKey',
      );

      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        if (data['status'] == 'OK') {
          final element = data['rows'][0]['elements'][0];
          if (element['status'] == 'OK') {
            distance = element['distance']['value'] / 1609.34;

            final durationSeconds = element['duration']['value'] as int;

            deliveryDurationInMinutes = (durationSeconds / 60).round();

            final now = DateTime.now();
            final deliveryDateTime = now.add(
              Duration(seconds: durationSeconds),
            );
            deliveryTime = "Deliver by ${_formatTime(deliveryDateTime)}";
          }
        }
      }
    } catch (e) {
      print('Error calling Google Distance Matrix API: $e');
    }

    String pickupItem = restaurantData['name'] as String;

    return DeliveryOrder(
      id: id,
      price: price,
      guaranteedLabel: "Guaranteed",
      distance: distance,
      deliveryTime: deliveryTime,
      pickupItem: pickupItem,
      dropoffLabel: "Customer Dropoff",
      deliveryDurationInMinutes: deliveryDurationInMinutes,
    );
  }

  static String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
}
