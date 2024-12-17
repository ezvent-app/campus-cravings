import 'package:auto_route/auto_route.dart';
import 'package:campus_cravings/router/router.gr.dart';
import 'package:campus_cravings/ui/pages/main/tabs/profile/widgets/profile_group_button.dart';
import 'package:campus_cravings/ui/widgets/base_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return BaseWrapper(
      label: 'Settings',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileGroupButton(
            topMargin: 0,
            options: [
              ProfileOption(
                icon: 'notification_icon',
                label: 'Notifications',
                onPressed: (){
                  context.pushRoute(const NotificationsRoute());
                },
              ),
              ProfileOption(
                icon: 'change_password_icon',
                label: 'Change Password',
                onPressed: (){
                  context.pushRoute(const ChangePasswordRoute());
                },
              ),
              ProfileOption(
                icon: 'change_language_icon',
                label: 'Change Language',
                onPressed: (){},
              ),
            ],
          ),
        ],
      ),
    );
  }
}