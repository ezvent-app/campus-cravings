import 'package:campus_cravings/src/src.dart';

@RoutePage()
class NotificationsPage extends ConsumerWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = AppLocalizations.of(context)!;
    return BaseWrapper(
      label: locale.notifications,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        locale.pushNotifications,
                        style:
                            TextStyle(fontSize: 15, color: Color(0xff2E3138)),
                      ),
                      height(12),
                      Text(
                        locale.enableNotifications,
                        style:
                            TextStyle(fontSize: 14, color: Color(0xff878E9B)),
                      ),
                    ],
                  ),
                ),
                width(15),
                Switch(
                  value: true,
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
          height(24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        locale.smsNotifications,
                        style:
                            TextStyle(fontSize: 15, color: Color(0xff2E3138)),
                      ),
                      height(12),
                      Text(
                        locale.enableSMSNotifications,
                        style:
                            TextStyle(fontSize: 14, color: Color(0xff878E9B)),
                      ),
                    ],
                  ),
                ),
                width(15),
                Switch(
                  value: true,
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
          height(24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        locale.emailNotifications,
                        style:
                            TextStyle(fontSize: 15, color: Color(0xff2E3138)),
                      ),
                      SizedBox(height: 12),
                      Text(
                        locale.dontMissEmailNotifications,
                        style:
                            TextStyle(fontSize: 14, color: Color(0xff878E9B)),
                      ),
                    ],
                  ),
                ),
                width(15),
                Switch(
                  value: true,
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
          height(24),
        ],
      ),
    );
  }
}
