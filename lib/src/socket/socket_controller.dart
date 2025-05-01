import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:campuscravings/src/src.dart';

class SocketController {
  final SocketService _socketService;
  final Ref _ref;

  SocketController(this._socketService, this._ref);

  void connect(String jwtToken) {
    _ref
        .read(socketStateProvider.notifier)
        .updateStatus(SocketStatus.connecting);

    _socketService.connect(jwtToken);

    // Handle connection events
    _socketService.on('connect', (_) {
      _ref
          .read(socketStateProvider.notifier)
          .updateStatus(SocketStatus.connected);
    });

    _socketService.on('disconnect', (_) {
      _ref
          .read(socketStateProvider.notifier)
          .updateStatus(SocketStatus.disconnected);
    });

    _socketService.on('error', (error) {
      _ref
          .read(socketStateProvider.notifier)
          .updateStatus(SocketStatus.error, error.toString());
    });

    // Add custom event listeners here
    _setupEventListeners();
  }

  void disconnect() {
    _socketService.disconnect();
    _ref
        .read(socketStateProvider.notifier)
        .updateStatus(SocketStatus.disconnected);
  }

  void _setupEventListeners() {
    // Define your Socket.IO event listeners here
    // Example:
    // _socketService.on('someEvent', (data) {
    //   print('Received someEvent: $data');
    // });
  }

  void listenForOrders(void Function(dynamic data) updateOrders) {
    _socketService.on(SocketEvents.newRiderOrder, (data) {
      print('Received orderStatusUpdated event: $data');
      updateOrders(data);
    });
  }

  void listenForStatusUpdates(
    void Function(Map<String, dynamic> data) onLocationUpdate,
  ) {
    _socketService.on(SocketEvents.orderStatusUpdated, (data) {
      print('Received orderStatusUpdated event: $data');
      onLocationUpdate(data);
    });
  }

  void stopListeningForStatusUpdates() {
    _socketService.off(SocketEvents.orderStatusUpdated);
    print('Stopped listening for locationUpdate');
  }

  void emitJoinConversation(String conversationId) {
    _socketService.emitWithAck(SocketEvents.joinConversation, {
      'conversationId': conversationId,
    });
  }

  void emitSendChatMessage(
    String conversationId,
    String text,
    bool isCustomer,
  ) {
    print(
      "Emitting sendChatMessage event with conversationId: $conversationId",
    );
    _socketService.emitWithAck(SocketEvents.sendChatMessage, {
      'conversationId': conversationId,
      'isCustomer': isCustomer,
      'text': text,
    });
  }

  void emitMarkMessageAsRead(String messageId, bool isCustomer) {
    print("Emitting markMessageAsRead event with messageId: $messageId");
    _socketService.emitWithAck(SocketEvents.markMessageRead, {
      'messageId': messageId,
      'isCustomer': isCustomer,
    });
  }

  void listenForNewMessages(void Function(Map<String, dynamic>) onNewMessage) {
    _socketService.on(SocketEvents.receiveChatMessage, (data) {
      print('Received newMessage event: $data');
      onNewMessage(data);
    });
  }

  void listenForReadMessages(
    void Function(Map<String, dynamic>) onMessageRead,
  ) {
    _socketService.on(SocketEvents.messagesRead, (data) {
      print('Received read Message event: $data');
      onMessageRead(data);
    });
  }

  void stopListeningForNewMessages() {
    _socketService.off(SocketEvents.sendChatMessage);
    print('Stopped listening for newMessage');
  }

  void emitJoinOrder(String orderId) {
    print('Emitting joinOrder event with orderId: $orderId');
    _socketService.emitWithAck(SocketEvents.joinOrderRoom, {
      'orderId': orderId,
    });
  }
}
