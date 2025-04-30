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
    final services = HttpAPIServices();
    print("TicketTabType: $type");
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
      physics: const BouncingScrollPhysics(),
      child: SizedBox(
        // Ensure Stack has enough height to display Positioned widget
        height: MediaQuery.of(context).size.height - kToolbarHeight - 150,
        child: Stack(
          children: [
            Column(
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
                            onAdd: (String ticketId, TicketMessage message) {
                              ref
                                  .read(ticketProvider.notifier)
                                  .addMessage(ticketId, message);
                              print("Messages: ${ticket.messages}");
                            },
                            onDelete:
                                () => ref
                                    .read(ticketProvider.notifier)
                                    .deleteTicket(ticket.id, context),
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
            if (type == TicketTabType.active)
              Positioned(
                right: 16,
                bottom: 40,
                child: FloatingActionButton(
                  onPressed: () async {
                    try {
                      final response = await services.postAPI(
                        url: "/admin/tickets",
                        map: {
                          "Subject": 'Pakistan Studies',
                          "Description": 'Need help with my assignment',
                          "imgUrl": [],
                        },
                      );
                      if (response.statusCode == 200) {
                        final body = response.body as Map<String, dynamic>;
                        ref
                            .read(ticketProvider.notifier)
                            .addTicket(body['ticket']);
                      }
                    } catch (e) {
                      print("Error: $e");
                      showToast("Failed to create ticket", context: context);
                    }
                  },
                  backgroundColor: Colors.purple,
                  child: Icon(
                    Icons.add_sharp,
                    color: AppColors.primary,
                    size: 30,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
