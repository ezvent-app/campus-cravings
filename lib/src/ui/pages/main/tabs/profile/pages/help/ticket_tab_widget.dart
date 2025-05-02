import 'package:campuscravings/src/src.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum TicketTabType { active, history }

class TicketTabWidget extends ConsumerWidget {
  final TicketTabType type;
  const TicketTabWidget({super.key, required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final services = HttpAPIServices();
    final tickets =
        ref.watch(ticketProvider).where((ticket) {
          return type == TicketTabType.active
              ? ticket.status == 'pending'
              : ticket.status != 'pending';
        }).toList();

    void handleTicketRouting(Ticket ticket) => context.pushRoute(
      TicketMessagesRoute(
        messages: ticket.messages,
        ticketId: ticket.id,
        onAdd: (String ticketId, TicketMessage message) {
          ref.read(ticketProvider.notifier).addMessage(ticketId, message);
        },
        onDelete:
            () => ref
                .read(ticketProvider.notifier)
                .deleteTicket(ticket.id, context),
      ),
    );

    return Stack(
      // Ensure Stack takes full available height
      children: [
        // Ticket list content
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
          physics: const BouncingScrollPhysics(),
          child: Column(
            spacing: 8,
            children: List.generate(tickets.length, (index) {
              final ticket = tickets[index];
              return ProfileGroupButton(
                options: [
                  HelpOption(
                    label: "Ticket#${ticket.id}",
                    onPressed: () => handleTicketRouting(ticket),
                  ),
                ],
                topMargin: 0,
                isHelp: true,
              );
            }),
          ),
        ),

        // Floating Action Button anchored to bottom-right
        if (type == TicketTabType.active)
          Positioned(
            bottom: 24, // Adjust based on your UI needs
            right: 24,
            child: FloatingActionButton(
              onPressed: () async {
                try {
                  final response = await services.postAPI(
                    url: "/admin/tickets",
                    map: {
                      "subject": 'Pakistan Studies',
                      "description": 'Need help with my assignment',
                      "imgUrl": [],
                    },
                  );
                  if (response.statusCode == 201) {
                    final body = jsonDecode(response.body);
                    ref.read(ticketProvider.notifier).addTicket(body['ticket']);
                    handleTicketRouting(Ticket.fromJson(body['ticket']));
                  }
                } catch (e) {
                  showToast("Failed to create ticket", context: context);
                }
              },
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.add, color: AppColors.white),
            ),
          ),
      ],
    );
  }
}
