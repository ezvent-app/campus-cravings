import 'package:campus_cravings/ui/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BaseWrapper extends ConsumerWidget {
  final String label;
  final Widget child;
  final bool hasHorizontalPadding;
  const BaseWrapper({
    super.key,
    this.label = '',
    required this.child,
    this.hasHorizontalPadding = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(label: label),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: hasHorizontalPadding ? 25 : 0,
                ),
                child: child,
              ),
            )
          ],
        ),
      ),
    );
  }
}
