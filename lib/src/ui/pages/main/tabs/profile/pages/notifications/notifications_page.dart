import 'package:campuscravings/src/src.dart';

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
          Consumer(
            builder: (context, ref, child) {
              var push = ref.watch(notificationProvider)['push'];
              return NotificationWidget(
                title: locale.pushNotifications,
                desc: locale.enableNotifications,
                isEnable: push!,
                onChange: (value) {
                  final pushProvider = ref.read(notificationProvider);
                  ref.read(notificationProvider.notifier).state = {
                    ...pushProvider,
                    'push': value,
                  };
                },
              );
            },
          ),
          height(24),

          Consumer(
            builder: (context, ref, child) {
              var sms = ref.watch(notificationProvider)['sms'];
              return NotificationWidget(
                title: locale.smsNotifications,
                desc: locale.enableSMSNotifications,
                isEnable: sms!,
                onChange: (value) {
                  final smsProvider = ref.read(notificationProvider);
                  ref.read(notificationProvider.notifier).state = {
                    ...smsProvider,
                    'sms': value,
                  };
                },
              );
            },
          ),
          height(24),
          Consumer(
            builder: (context, ref, child) {
              var email = ref.watch(notificationProvider)['email'];
              return NotificationWidget(
                title: locale.emailNotifications,
                desc: locale.dontMissEmailNotifications,
                isEnable: email!,
                onChange: (value) {
                  final emailProvider = ref.read(notificationProvider);
                  ref.read(notificationProvider.notifier).state = {
                    ...emailProvider,
                    'email': value,
                  };
                },
              );
            },
          ),

          height(24),
        ],
      ),
    );
  }
}

final notificationProvider = StateProvider<Map<String, bool>>(
  (ref) => {'push': true, 'sms': true, 'email': true},
);
