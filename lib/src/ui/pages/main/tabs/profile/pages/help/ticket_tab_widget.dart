import 'package:campuscravings/src/src.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Enum for ticket tab types
enum TicketTabType { active, history }

// ConsumerWidget for displaying tickets
class TicketTabWidget extends ConsumerWidget {
  final TicketTabType type;
  const TicketTabWidget({super.key, required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = AppLocalizations.of(context)!;
    // Watch the ticket list from the provider, filter based on type
    final tickets =
        ref.watch(ticketProvider).where((ticket) {
          print("Status: ${ticket.status}");
          return type == TicketTabType.active
              ? ticket.status == 'pending'
              : ticket.status != 'pending';
        }).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      physics: BouncingScrollPhysics(),
      child: Column(
        spacing: 15,
        children: List.generate(tickets.length, (index) {
          final ticket = tickets[index];
          return ProfileGroupButton(
            options: [
              HelpOption(
                label: "Ticket#${ticket.id}",
                onPressed: () {
                  context.pushRoute(
                    TicketMessagesRoute(
                      messages: ticket.messages,
                      ticketId: ticket.id,
                      // Pass the delete method to the next route/widget
                      onDelete:
                          () => ref
                              .read(ticketProvider.notifier)
                              .deleteTicket(ticket.id),
                    ),
                  );
                },
              ),
            ],
            topMargin: 0,
            isHelp: true,
          );
        }),
      ),
    );
  }
}
