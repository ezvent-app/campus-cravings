import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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