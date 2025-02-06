

import 'package:campus_cravings/src/src.dart';

@RoutePage()
class OrdersTab extends ConsumerStatefulWidget {
  const OrdersTab({super.key});

  @override
  ConsumerState createState() => _OrdersTabState();
}

class _OrdersTabState extends ConsumerState<OrdersTab> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Orders'),),
    );
  }
}