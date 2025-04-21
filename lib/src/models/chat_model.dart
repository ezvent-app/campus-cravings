class ChatModel {
  final String message;
  final String timestamp;
  final bool isRead;

  ChatModel(
      {required this.message, required this.timestamp, required this.isRead});
}

List<ChatModel> chatsList = [
  ChatModel(
      message: "Hello, good afternoon Andrew... ",
      timestamp: "3:12 pm",
      isRead: false),
  ChatModel(
      message:
          "I'm Robert, I'll be right over and take your order. Please wait... ",
      timestamp: "3:12 pm",
      isRead: false),
  ChatModel(
      message:
          "Hello Rayford, ok I will be waiting for you in front of my house. You can immediately notify me when it arrives  ",
      timestamp: "3:12 pm",
      isRead: true),
  ChatModel(
      message: "Great! I will arrive soon...",
      timestamp: "3:12 pm",
      isRead: false),
];

List<ChatModel> helpCenterChatsList = [
  ChatModel(
      message:
          "Hi, I didn’t receive my order. It says delivered, but I didn’t get it.",
      timestamp: "3:12 pm",
      isRead: false),
  ChatModel(
      message:
          "Hi, we’re sorry to hear that! Let me check the details for your order. Can you please share your order ID?",
      timestamp: "3:12 pm",
      isRead: false),
  ChatModel(message: "Sure, it’s #12345.", timestamp: "3:12 pm", isRead: true),
  ChatModel(
      message:
          "Thank you! I see your order was marked delivered 10 minutes ago to Dorm 210. Could you double-check if it was left at the door or with someone nearby?",
      timestamp: "3:12 pm",
      isRead: false),
];
