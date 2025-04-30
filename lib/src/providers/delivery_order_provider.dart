import 'package:campuscravings/src/models/delivery_order_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider to hold the list of delivery orders
final deliveryOrdersProvider = StateProvider<List<DeliveryOrder>>((ref) => []);

// Provider to manage socket data and update delivery orders
final socketDeliveryControllerProvider = Provider<SocketDeliveryController>((
  ref,
) {
  return SocketDeliveryController(ref);
});

class SocketDeliveryController {
  final Ref ref;

  SocketDeliveryController(this.ref);

  Future<void> handleSocketData(dynamic data) async {
    if (data is Map<String, dynamic> && data.containsKey('orders')) {
      final List<dynamic> ordersData = data['orders'] as List<dynamic>;
      final restaurantData = data['restaurant'] as Map<String, dynamic>;

      // Filter orders to only include those with status "pending"
      final pendingOrders =
          ordersData.where((order) => order['status'] == 'pending').toList();

      // Process each order to calculate distance and delivery time
      List<DeliveryOrder> newOrders = [];
      for (var orderData in ordersData) {
        final deliveryOrder = await DeliveryOrder.fromSocketData(
          orderData as Map<String, dynamic>,
          restaurantData,
        );
        newOrders.add(deliveryOrder);
      }

      print('New pending orders received: $newOrders');

      // Update the provider with the new orders
      ref.read(deliveryOrdersProvider.notifier).state = newOrders;
    }
  }
}
