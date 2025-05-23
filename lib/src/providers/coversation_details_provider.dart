import 'package:campuscravings/src/models/converstation_details.dart';
import 'package:campuscravings/src/providers/chat_provider.dart';
import 'package:campuscravings/src/src.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import '../models/chat.dart';
import '../services/http_service.dart';

class ConversationNotifier
    extends StateNotifier<AsyncValue<ConversationDetails?>> {
  final Ref ref;
  final String orderId;
  final bool isCustomer;
  final HttpService _httpService = HttpService();

  ConversationNotifier(this.ref, this.orderId, this.isCustomer)
    : super(const AsyncValue.loading()) {
    _fetchConversationDetails();
  }

  void setConversationDetails(ConversationDetails details) {
    state = AsyncValue.data(details);

    // Initialize chat notifier with fetched messages if there are any
    if (details.messages != null && details.messages.isNotEmpty) {
      ref
          .read(chatNotifierProvider(details.conversationId).notifier)
          .state = AsyncValue.data(details.messages);

      // Mark unread messages as read
      // for (final chat in details.messages) {
      //   if (chat.status == 'sent' &&
      //       chat.senderModel != (isCustomer ? 'User' : 'Rider')) {
      //     // ref
      //     //     .read(chatNotifierProvider(details.conversationId).notifier)
      //     //     .markAsRead(chat.id);
      //   }
      // }
    } else {
      // Initialize with empty list if no messages
      ref
          .read(chatNotifierProvider(details.conversationId).notifier)
          .state = const AsyncValue.data([]);
    }

    // Join the conversation room via socket
    final socketController = ref.read(socketControllerProvider);
    if (ref.read(socketStateProvider).status == SocketStatus.connected) {
      socketController.listenForNewMessages((Map<String, dynamic> data) {
        final newMessage = Chat.fromJson(data["newMessage"]);
        ref
            .read(chatNotifierProvider(details.conversationId).notifier)
            .addMessage(newMessage);

        // Mark the message as read if it's not from the current user
        if (newMessage.senderModel != (isCustomer ? 'User' : 'Rider')) {
          // ref
          //     .read(chatNotifierProvider(details.conversationId).notifier)
          //     .markAsRead(newMessage.id);
          socketController.emitMarkMessageAsRead(newMessage.id, isCustomer);
        }
      });
      socketController.listenForReadMessages((Map<String, dynamic> data) {
        final ids = data["messageIds"] as List<String>;
        ref
            .read(chatNotifierProvider(details.conversationId).notifier)
            .markMessagesAsRead(ids);
      });
      socketController.emitJoinConversation(details.conversationId);
      debugPrint('Joined conversation room: ${details.conversationId}');
    } else {
      debugPrint('Socket not connected, cannot join conversation room');
    }
  }

  Future<void> _fetchConversationDetails() async {
    try {
      state = const AsyncValue.loading();

      final endpoint =
          '/conversation/getConversationDetails?orderId=$orderId&isCustomer=$isCustomer';

      // Make the API call using HttpService
      final res = await _httpService.getRequest(endpoint);
      final response = jsonDecode(res.body) as Map<String, dynamic>;

      if (response.containsKey('conversationDetails')) {
        final detailsData = response['conversationDetails'];

        // Parse messages if they exist
        List<Chat> messages = [];
        if (detailsData['messages'] != null &&
            detailsData['messages'] is List) {
          messages =
              (detailsData['messages'] as List)
                  .map((messageJson) => Chat.fromJson(messageJson))
                  .toList();
        }

        // Create ConversationDetails object
        final conversationDetails = ConversationDetails(
          conversationId: detailsData['conversationId'] as String,
          recipientName: detailsData['name'] as String,
          messages: messages,
        );

        // Update state using setConversationDetails which handles socket events
        setConversationDetails(conversationDetails);
      } else {
        // Handle case where conversationDetails is not in response
        debugPrint('No conversation details found in API response');
        state = const AsyncValue.data(null);
      }
    } catch (e, stackTrace) {
      debugPrint('Error fetching conversation details: $e');
      state = AsyncValue.error(e, stackTrace);
    }
  }

  // Method to refresh conversation details
  Future<void> refreshConversationDetails() async {
    await _fetchConversationDetails();
  }
}

class ConversationParams {
  final String orderId;
  final bool isCustomer;

  ConversationParams({required this.orderId, required this.isCustomer});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConversationParams &&
          runtimeType == other.runtimeType &&
          orderId == other.orderId &&
          isCustomer == other.isCustomer;

  @override
  int get hashCode => orderId.hashCode ^ isCustomer.hashCode;
}

// Providers
final conversationNotifierProvider = StateNotifierProvider.family<
  ConversationNotifier,
  AsyncValue<ConversationDetails?>,
  ConversationParams
>(
  (ref, params) => ConversationNotifier(ref, params.orderId, params.isCustomer),
);
