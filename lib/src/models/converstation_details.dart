import 'package:campuscravings/src/models/chat.dart';

class ConversationDetails {
  final String conversationId;
  final String recipientName;
  final List<Chat> messages;

  ConversationDetails({
    required this.conversationId,
    required this.recipientName,
    required this.messages,
  });
}
