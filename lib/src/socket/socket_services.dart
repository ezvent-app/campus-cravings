import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:campuscravings/src/src.dart';

class SocketService {
  io.Socket? _socket;

  void connect(String jwtToken) {
    _socket = io.io(
      SocketEvents.socketUrl,
      io.OptionBuilder().setTransports(['websocket']).setAuth({
        'token': jwtToken,
      }) // Pass JWT token in handshake
      .build(),
    );

    _socket?.onConnect((_) {
      print('Socket connected');
    });

    _socket?.onDisconnect((_) {
      print('Socket disconnected');
    });

    _socket?.onError((error) {
      print('Socket error: $error');
    });
  }

  void disconnect() {
    _socket?.disconnect();
    _socket = null;
  }

  void emit(String event, dynamic data) {
    _socket?.emit(event, data);
  }

  void emitWithAck(String event, dynamic data) {
    _socket?.emitWithAck(
      event,
      data,
      ack: (response) {
        // Handle the acknowledgment response
        print("Acknowledgment received for event: $event");
        if (response != null && response['success'] == true) {
          print('Emit successful: ${response['message']}');
        } else {
          print('Emit failed: ${response['error'] ?? 'Unknown error'}');
        }
      },
    );
  }

  void on(String event, Function(dynamic) callback) {
    _socket?.on(event, callback);
  }

  bool get isConnected => _socket?.connected ?? false;
}
