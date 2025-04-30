import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chat.dart';
import 'package:campuscravings/src/src.dart'; // For HttpService

class ChatNotifier extends StateNotifier<AsyncValue<List<Chat>>> {
  final String conversationId;
  final Ref ref;

  ChatNotifier(this.ref, this.conversationId)
    : super(const AsyncValue.loading()) {}

  // Future<void> sendMessage({
  //   required String senderId,
  //   required String senderModel,
  //   required String text,
  // }) async {
  //   try {
  //     await ref
  //         .read(apiServiceProvider)
  //         .sendMessage(
  //           conversationId: conversationId,
  //           senderId: senderId,
  //           senderModel: senderModel,
  //           text: text,
  //         ); // Refresh the chat list
  //   } catch (e) {
  //     state = AsyncValue.error(e, StackTrace.current);
  //   }
  // }

  // Future<void> markAsRead(String messageId) async {
  //   try {
  //     await ref
  //         .read(apiServiceProvider)
  //         .markMessageAsRead(conversationId, messageId);
  //     final chats = state.value ?? [];
  //     state = AsyncValue.data(
  //       chats.map((chat) {
  //         if (chat.id == messageId) {
  //           return Chat(
  //             id: chat.id,
  //             conversation: chat.conversation,
  //             sender: chat.sender,
  //             senderModel: chat.senderModel,
  //             text: chat.text,
  //             status: 'read',
  //             createdAt: chat.createdAt,
  //             updatedAt: chat.updatedAt,
  //           );
  //         }
  //         return chat;
  //       }).toList(),
  //     );
  //   } catch (e) {
  //     state = AsyncValue.error(e, StackTrace.current);
  //   }
  // }

  void addMessage(Chat newMessage) {
    final chats = state.value ?? [];
    state = AsyncValue.data([...chats, newMessage]);
  }
}

// Providers
final chatNotifierProvider =
    StateNotifierProvider.family<ChatNotifier, AsyncValue<List<Chat>>, String>(
      (ref, conversationId) => ChatNotifier(ref, conversationId),
    );

// final apiServiceProvider = Provider<ApiService>((ref) {
//   final httpService = HttpService();
//   return ApiService(httpService);
// });
