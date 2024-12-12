import 'package:campus_cravings/constants/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDescriptionWidget extends ConsumerStatefulWidget {
  const ProductDescriptionWidget({super.key});

  @override
  ConsumerState createState() => _ProductDescriptionWidgetState();
}

class _ProductDescriptionWidgetState extends ConsumerState<ProductDescriptionWidget> {
  final String description = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';

  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: description.length > 14 ? !_expanded ? '${description.substring(0, 151)}...' : description : description,
              style: const TextStyle(
                fontFamily: 'SofiaPro',
                fontSize: 12,
                height: 1.5,
                color: Color(0xFF7D7D78),
              ),
            ),
            if (description.length > 40) TextSpan(
              text: ' Read ${_expanded ? 'Less' : 'More'}',
              style: const TextStyle(
                fontFamily: 'SofiaPro',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.accent,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
            ),
          ],
        ),
      ),
    );
  }
}
