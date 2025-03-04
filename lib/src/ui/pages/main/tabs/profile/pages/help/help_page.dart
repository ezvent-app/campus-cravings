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
                onPressed: () => context.pushRoute(HelpFAQRoute(
                    type: FAQS.order,
                    title: locale.order,
                    faqs: helpOrderModelList)),
              ),
              HelpOption(
                label: locale.delivery,
                onPressed: () => context.pushRoute(HelpFAQRoute(
                    type: FAQS.delivery,
                    title: locale.delivery,
                    faqs: helpOrderModelList)),
              ),
              HelpOption(
                label: locale.payment,
                onPressed: () => context.pushRoute(HelpFAQRoute(
                    type: FAQS.payment,
                    title: locale.payment,
                    faqs: helpOrderModelList)),
              ),
              HelpOption(
                label: locale.promotion,
                onPressed: () => context.pushRoute(HelpFAQRoute(
                    type: FAQS.promotion,
                    title: locale.promotion,
                    faqs: helpOrderModelList)),
              ),
              HelpOption(
                label: locale.account,
                onPressed: () => context.pushRoute(HelpFAQRoute(
                    type: FAQS.account,
                    title: locale.account,
                    faqs: helpOrderModelList)),
              ),
              HelpOption(
                label: locale.refund,
                onPressed: () => context.pushRoute(HelpFAQRoute(
                    type: FAQS.refund,
                    title: locale.refund,
                    faqs: helpOrderModelList)),
              ),
              HelpOption(
                label: locale.contactSupport,
                onPressed: () => context.pushRoute(const ContactSupportRoute()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
