import 'package:campus_cravings/src/src.dart';

@RoutePage()
class OrdersTabPage extends ConsumerStatefulWidget {
  const OrdersTabPage({super.key});

  @override
  ConsumerState createState() => _OrdersTabState();
}

class _OrdersTabState extends ConsumerState<OrdersTabPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Orders'),
      ),
    );
  }
}
