import 'package:campuscravings/src/src.dart';

@RoutePage()
class PromoCodePage extends ConsumerWidget {
  const PromoCodePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = AppLocalizations.of(context)!;
    return BaseWrapper(
      label: locale.promoCode,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Please enter the promo code you received via email, SMS, or other official communications to redeem your discount.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          height(50),
          CustomTextField(
            label: locale.enterPromoCode,
            hintText: locale.size20Per,
            hintStyle: TextStyle(color: Color(0xffA6A6A6)),
          ),
          height(30),
          RoundedButtonWidget(
            btnTitle: locale.apply,
            onTap: () {
              context.maybePop();
            },
          ),
        ],
      ),
    );
  }
}
