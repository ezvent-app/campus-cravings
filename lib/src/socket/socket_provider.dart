import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:campuscravings/src/src.dart';

// SocketService provider
final socketServiceProvider = Provider<SocketService>((ref) {
  return SocketService();
});

// SocketController provider
final socketControllerProvider = Provider<SocketController>((ref) {
  final socketService = ref.watch(socketServiceProvider);
  return SocketController(socketService, ref);
});

// SocketState provider
final socketStateProvider =
    StateNotifierProvider<SocketStateNotifier, SocketState>((ref) {
      return SocketStateNotifier();
    });

class SocketStateNotifier extends StateNotifier<SocketState> {
  SocketStateNotifier() : super(SocketState(status: SocketStatus.initial));

  void updateStatus(SocketStatus status, [String? error]) {
    state = state.copyWith(status: status, error: error);
  }
}
