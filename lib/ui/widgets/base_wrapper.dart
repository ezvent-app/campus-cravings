import 'package:campus_cravings/ui/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BaseWrapper extends ConsumerWidget {
  final String label;
  final Widget child;
  const BaseWrapper({super.key, this.label = '', required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(label: label),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: child,
            )
          ],
        ),
      ),
    );
  }
}
