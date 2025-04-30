import 'dart:convert';
import 'package:campuscravings/src/src.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class RaiseTicketPage extends ConsumerStatefulWidget {
  RaiseTicketPage({super.key});
  final HttpAPIServices services = HttpAPIServices();

  @override
  ConsumerState<RaiseTicketPage> createState() => _RaiseTicketPageState();
}

class _RaiseTicketPageState extends ConsumerState<RaiseTicketPage> {
  @override
  void initState() {
    super.initState();
    _fetchTickets();
  }

  Future<void> _fetchTickets() async {
    try {
      final response = await widget.services.getAPI('/user/tickets');
      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      final List<Ticket> tickets =
          (data['tickets'] as List<dynamic>)
              .map((ticket) => Ticket.fromJson(ticket as Map<String, dynamic>))
              .toList();
      ref.read(ticketProvider.notifier).setTickets(tickets);
    } catch (e) {
      debugPrint('Error fetching tickets: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to load tickets')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Raise ticket",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffE2E2E2)),
                borderRadius: BorderRadius.circular(18),
                color: const Color(0xffF2F2F2),
              ),
              child: TabBar(
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.primary,
                ),
                unselectedLabelColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.transparent,
                dividerColor: Colors.transparent,
                unselectedLabelStyle: const TextStyle(color: AppColors.black),
                labelColor: AppColors.white,
                labelStyle: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(color: AppColors.white),
                tabs: [
                  Tab(
                    child: Container(
                      height: 44,
                      alignment: Alignment.center,
                      child: const Text("Active Tickets"),
                    ),
                  ),
                  Tab(
                    child: Container(
                      height: 44,
                      alignment: Alignment.center,
                      child: Text(locale.history),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  TicketTabWidget(type: TicketTabType.active),
                  TicketTabWidget(type: TicketTabType.history),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TicketNotifier extends StateNotifier<List<Ticket>> {
  final HttpAPIServices services;

  TicketNotifier(this.services) : super([]);

  Future<void> fetchTickets() async {
    try {
      final response = await services.getAPI('/user/tickets');
      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      final List<Ticket> tickets =
          (data['tickets'] as List<dynamic>)
              .map((ticket) => Ticket.fromJson(ticket as Map<String, dynamic>))
              .toList();
      state = tickets;
    } catch (e) {
      debugPrint('Error fetching tickets: $e');
      // Note: SnackBar requires BuildContext, handled in UI
    }
  }

  void addTicket(Map<String, dynamic> ticketData) {
    final ticket = Ticket.fromJson(ticketData);
    state = [...state, ticket];
  }

  void addMessage(String ticketId, TicketMessage message) {
    state = [
      for (final ticket in state)
        ticket.id == ticketId
            ? ticket.copyWith(messages: [...ticket.messages, message])
            : ticket,
    ];
  }

  void setTickets(List<Ticket> tickets) {
    state = tickets;
  }

  void deleteTicket(String ticketId, BuildContext context) async {
    try {
      final response = await services.patchAPI(
        url: "/admin/tickets/$ticketId",
        map: {"status": "resolved"},
      );
      if (response.statusCode == 200) {
        state = [
          for (final ticket in state)
            ticket.id == ticketId
                ? ticket.copyWith(status: " homenagem")
                : ticket,
        ];
      } else {
        showToast("Failed to delete ticket", context: context);
      }
    } catch (e) {
      debugPrint('Error fetching tickets: $e');
      // Note: SnackBar requires BuildContext, handled in UI
    }
  }
}

final ticketProvider = StateNotifierProvider<TicketNotifier, List<Ticket>>((
  ref,
) {
  return TicketNotifier(HttpAPIServices());
});
