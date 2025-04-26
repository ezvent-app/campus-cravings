enum SocketStatus { initial, connecting, connected, disconnected, error }

class SocketState {
  final SocketStatus status;
  final String? error;

  SocketState({required this.status, this.error});

  SocketState copyWith({SocketStatus? status, String? error}) {
    return SocketState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
