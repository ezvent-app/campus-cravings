

import 'package:campus_cravings/src/src.dart';

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