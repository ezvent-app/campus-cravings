import 'package:campuscravings/src/src.dart';

@RoutePage()
class RaiseTicketPage extends StatelessWidget {
  const RaiseTicketPage({super.key});

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
                unselectedLabelStyle: TextStyle(color: AppColors.black),
                labelColor: AppColors.white,
                labelStyle: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(color: AppColors.white),
                tabs: [
                  Tab(
                    child: Container(
                      height: 44,
                      alignment: Alignment.center,
                      child: Text("Active Tickets"),
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
