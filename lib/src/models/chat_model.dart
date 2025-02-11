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
