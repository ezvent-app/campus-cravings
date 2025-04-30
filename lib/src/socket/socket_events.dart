class SocketEvents {
  static const String socketUrl =
      'http://192.168.18.53:5000/'; // Replace with your backend URL
  static const String eventOrderPlaced = 'orderPlaced';
  static const String eventOrderStatusUpdated = 'orderStatusUpdated';
  static const String eventDeliveryLocationUpdated = 'deliveryLocationUpdated';
  static const String eventNotification = 'notification';
  static const String joinOrderRoom = 'join-order-room';
  static const String orderStatusUpdated = 'order-status-updated';
  static const String newRiderOrder = 'new-rider-order';
}
