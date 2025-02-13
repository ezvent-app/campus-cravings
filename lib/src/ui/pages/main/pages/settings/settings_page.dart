import 'package:campus_cravings/src/src.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return BaseWrapper(
      label: locale.settings,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileGroupButton(
            topMargin: 0,
            options: [
              ProfileOption(
                icon: 'notification_icon',
                label: locale.notifications,
                onPressed: () {
                  context.pushRoute(const NotificationsRoute());
                },
              ),
              ProfileOption(
                icon: 'change_password_icon',
                label: locale.changePassword,
                onPressed: () {
                  context.pushRoute(const ChangePasswordRoute());
                },
              ),
              ProfileOption(
                icon: 'change_language_icon',
                label: locale.changeLanguage,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
