import 'package:campuscravings/src/src.dart';

@RoutePage()
class TicketMessagesPage extends StatelessWidget {
  final String ticketId;
  final Function? onDelete;
  final List<TicketMessage> messages;
  const TicketMessagesPage({
    super.key,
    required this.ticketId,
    this.onDelete,
    required this.messages,
  });

  @override
  Widget build(BuildContext context) {
    print("Messages: $messages");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ticket#$ticketId",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              onDelete?.call();
              context.maybePop();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: messages.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final message = messages[index];
            final isUser =
                message.sender ==
                'user'; // Assuming sender is 'user' or 'admin'
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment:
                    isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: isUser ? AppColors.black : AppColors.halfWhite,
                      borderRadius:
                          isUser
                              ? const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(2),
                              )
                              : const BorderRadius.only(
                                topLeft: Radius.circular(2),
                                topRight: Radius.circular(16),
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        message.text,
                        style: TextStyle(
                          color: isUser ? AppColors.white : AppColors.black,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    message.time.toIso8601String(), // Display timestamp
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
