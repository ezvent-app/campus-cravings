class SocketEvents {
  static const String socketUrl = 'http://192.168.100.8:5000/';
  static const String eventOrderPlaced = 'orderPlaced';
  static const String eventOrderStatusUpdated = 'orderStatusUpdated';
  static const String eventDeliveryLocationUpdated = 'deliveryLocationUpdated';
  static const String eventNotification = 'notification';
  static const String joinOrderRoom = 'join-order-room';
  static const String orderStatusUpdated = 'order-status-updated';
  static const String newRiderOrder = 'new-rider-order';
  static const String joinConversation = 'join-conversation';
  static const String leaveConversation = 'leave-conversation';
  static const String sendChatMessage = 'send-chat-message';
  static const String receiveChatMessage = 'receive-chat-message';
  static const String markMessageRead = 'mark-message-read';
  static const String messagesRead = 'messages-read';
}
