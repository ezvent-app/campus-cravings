class Ticket {
  final String id;
  final String subject;
  final String description;
  final String userId;
  final String status; // e.g., "archive", "resolved", "pending"
  final String priority; // e.g., "low"
  final List<String> imgUrl;
  final List<TicketMessage> messages;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool read;

  Ticket({
    required this.id,
    required this.subject,
    required this.description,
    required this.userId,
    required this.status,
    required this.priority,
    required this.imgUrl,
    required this.messages,
    required this.createdAt,
    required this.updatedAt,
    required this.read,
  });

  // Factory method to create a Ticket from JSON
  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['_id'] as String,
      subject: json['subject'] as String,
      description: json['description'] as String,
      userId: json['userId'] as String,
      status: json['status'] as String,
      priority: json['priority'] as String,
      imgUrl: List<String>.from(json['imgUrl'] as List),
      messages:
          (json['messages'] as List)
              .map((msg) => TicketMessage.fromJson(msg as Map<String, dynamic>))
              .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      read: json['read'] as bool,
    );
  }

  Ticket copyWith({
    String? id,
    String? subject,
    String? description,
    String? userId,
    String? status,
    String? priority,
    List<String>? imgUrl,
    List<TicketMessage>? messages,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? read,
  }) {
    return Ticket(
      id: id ?? this.id,
      subject: subject ?? this.subject,
      description: description ?? this.description,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      imgUrl: imgUrl ?? this.imgUrl,
      messages: messages ?? this.messages,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      read: read ?? this.read,
    );
  }

  // Helper to determine if the ticket is active
  bool get isActive =>
      status == 'pending' || status == 'open'; // Adjust based on your logic
}

class TicketMessage {
  final String sender;
  final String text;
  final List<String> imageUrl;
  final String id;
  final DateTime time;

  TicketMessage({
    required this.sender,
    required this.text,
    required this.imageUrl,
    required this.id,
    required this.time,
  });

  factory TicketMessage.fromJson(Map<String, dynamic> json) {
    return TicketMessage(
      sender: json['sender'] as String,
      text: json['text'] as String,
      imageUrl: List<String>.from(json['imageUrl'] as List),
      id: json['_id'] as String,
      time: DateTime.parse(json['time'] as String),
    );
  }
}
