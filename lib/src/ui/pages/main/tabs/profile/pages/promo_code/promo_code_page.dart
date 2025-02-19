import 'package:campus_cravings/src/src.dart';

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
          CustomTextField(
            label: locale.enterPromoCode,
            hintText: locale.size20Per,
            hintStyle: TextStyle(color: Color(0xffA6A6A6)),
          ),
          height(24),
          RoundedButtonWidget(
              btnTitle: locale.apply,
              onTap: () {
                context.maybePop();
              })
        ],
      ),
    );
  }
}
