import 'package:campuscravings/src/src.dart';
import 'package:campuscravings/src/ui/pages/main/tabs/profile/pages/help/pages/raise_ticket/raise_ticket_tab.dart';

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
                onPressed:
                    () => context.pushRoute(
                      HelpFAQRoute(
                        type: FAQS.order,
                        title: locale.order,
                        faqs: orderFaqList,
                      ),
                    ),
              ),
              HelpOption(
                label: locale.delivery,
                onPressed:
                    () => context.pushRoute(
                      HelpFAQRoute(
                        type: FAQS.delivery,
                        title: locale.delivery,
                        faqs: deliveryFaqList,
                      ),
                    ),
              ),
              HelpOption(
                label: locale.payment,
                onPressed:
                    () => context.pushRoute(
                      HelpFAQRoute(
                        type: FAQS.payment,
                        title: locale.payment,
                        faqs: paymentFaqList,
                      ),
                    ),
              ),
              HelpOption(
                label: locale.account,
                onPressed:
                    () => context.pushRoute(
                      HelpFAQRoute(
                        type: FAQS.account,
                        title: locale.account,
                        faqs: accountFaqList,
                      ),
                    ),
              ),
            ],
          ),
          ProfileGroupButton(
            isHelp: true,
            options: [
              HelpOption(
                label: "Raise a Ticket",
                onPressed: () {
                  context.pushRoute(RaiseTicketRoute());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
