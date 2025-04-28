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
          return type == TicketTabType.active
              ? ticket.isActive
              : !ticket.isActive;
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

// Simple Ticket model
class Ticket {
  final String id;
  final bool isActive;

  Ticket({required this.id, required this.isActive});
}

// StateNotifier to manage the list of tickets
class TicketNotifier extends StateNotifier<List<Ticket>> {
  TicketNotifier()
    : super([
        Ticket(id: "1", isActive: true),
        Ticket(id: "2", isActive: true),
        Ticket(id: "3", isActive: false),
      ]);

  void deleteTicket(String ticketId) {
    state = state.where((ticket) => ticket.id != ticketId).toList();
  }
}

// Provider for the ticket list
final ticketProvider = StateNotifierProvider<TicketNotifier, List<Ticket>>((
  ref,
) {
  return TicketNotifier();
});
