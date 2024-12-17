import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppBar extends ConsumerWidget {
  final String label;
  const CustomAppBar({super.key, this.label = ''});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 32),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: IconButton(
                onPressed: ()=> context.maybePop(),
                icon: const Icon(Icons.arrow_back, size: 28,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                label,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700
                ),
              ),
            )
          ],
        ),
      );
  }
}
