import 'package:campuscravings/src/src.dart';

@RoutePage()
class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return BaseWrapper(
      label: locale.help,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileGroupButton(
            topMargin: 0,
            isHelp: true,
            options: [
              HelpOption(
                label: locale.order,
                onPressed: () {
                  context.pushRoute(const HelpOrderRoute());
                },
              ),
              HelpOption(label: locale.delivery, onPressed: () {}),
              HelpOption(label: locale.payment, onPressed: () {}),
              HelpOption(label: locale.promotion, onPressed: () {}),
              HelpOption(label: locale.account, onPressed: () {}),
              HelpOption(label: locale.refund, onPressed: () {}),
              HelpOption(
                label: locale.contactSupport,
                onPressed: () {
                  context.pushRoute(const ContactSupportRoute());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
