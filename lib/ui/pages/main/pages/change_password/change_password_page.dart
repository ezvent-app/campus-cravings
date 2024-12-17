import 'package:auto_route/auto_route.dart';
import 'package:campus_cravings/ui/widgets/base_wrapper.dart';
import 'package:campus_cravings/ui/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ChangePasswordPage extends ConsumerStatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  ConsumerState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends ConsumerState<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    return const BaseWrapper(
      label: 'Change Password',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            label: 'Enter Old Password',
            obscureText: true,
          ),
          SizedBox(height: 16),
          CustomTextField(
            label: 'Enter New Password',
            obscureText: true,
          ),
          SizedBox(height: 16),
          CustomTextField(
            label: 'Confirm New Password',
            obscureText: true,
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}