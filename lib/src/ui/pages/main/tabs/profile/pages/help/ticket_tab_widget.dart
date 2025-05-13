import 'package:campuscravings/src/src.dart';

enum TicketTabType { active, history }

class TicketTabWidget extends ConsumerWidget {
  final TicketTabType type;
  TicketTabWidget({super.key, required this.type});

  TextEditingController subjectController = TextEditingController();
  TextEditingController descController = TextEditingController();

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
            spacing: 15,
            children: List.generate(tickets.length, (index) {
              final ticket = tickets[index];
              return ProfileGroupButton(
                options: [
                  HelpOption(
                    label: "Ticket\n${ticket.id}",
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
                generateTicketDialogMethod(
                  context,
                  services,
                  ref,
                  handleTicketRouting,
                );
              },
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.add, color: AppColors.white),
            ),
          ),
      ],
    );
  }

  Future<dynamic> generateTicketDialogMethod(
    BuildContext context,
    HttpAPIServices services,
    WidgetRef ref,
    void Function(Ticket ticket) handleTicketRouting,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Center(child: Text("Generate Ticket")),
          titleTextStyle: Theme.of(context).textTheme.titleSmall,
          contentPadding: EdgeInsets.all(20),
          alignment: Alignment.center,
          children: [
            height(20),
            CustomTextField(
              controller: subjectController,
              hintText: "Enter subject",
            ),
            height(20),
            CustomTextField(
              controller: descController,
              hintText: "Enter description",
            ),
            height(20),
            RoundedButtonWidget(
              btnTitle: "Submit",
              onTap: () async {
                if (subjectController.text.isNotEmpty &&
                    descController.text.isNotEmpty) {
                  try {
                    final response = await services.postAPI(
                      url: "/admin/tickets",
                      map: {
                        "subject": subjectController.text,
                        "description": descController.text,
                        "imgUrl": [],
                      },
                    );
                    if (response.statusCode == 201) {
                      final body = jsonDecode(response.body);
                      ref
                          .read(ticketProvider.notifier)
                          .addTicket(body['ticket']);
                      handleTicketRouting(Ticket.fromJson(body['ticket']));
                      context.back();
                    }
                  } catch (e) {
                    showToast("Failed to create ticket", context: context);
                  }
                } else {
                  showToast(
                    "Subject and description can't empty",
                    context: context,
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
