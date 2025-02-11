import 'package:campus_cravings/src/src.dart';

@RoutePage()
class CheckoutPage extends ConsumerStatefulWidget {
  const CheckoutPage({super.key});

  @override
  ConsumerState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends ConsumerState<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Checkout Orders',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
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
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: AppColors.white),
                tabs: [
                  Tab(
                    child: Container(
                      height: 44,
                      alignment: Alignment.center,
                      child: Text(
                        'Delivery',
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      height: 44,
                      alignment: Alignment.center,
                      child: Text(
                        'Pickup',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  DeliveryTabWidget(),
                  PickUpTabWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
