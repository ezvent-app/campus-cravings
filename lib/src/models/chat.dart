class Chat {
  final String id;
  final String conversation;
  final String sender;
  final String senderModel;
  final String text;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Chat({
    required this.id,
    required this.conversation,
    required this.sender,
    required this.senderModel,
    required this.text,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['_id'] as String,
      conversation: json['conversation'] as String,
      sender: json['sender'] as String,
      senderModel: json['senderModel'] as String,
      text: json['text'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'conversation': conversation,
      'sender': sender,
      'senderModel': senderModel,
      'text': text,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
