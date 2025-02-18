import 'package:campus_cravings/src/src.dart';

@RoutePage()
class PromoCodePage extends ConsumerWidget {
  const PromoCodePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = AppLocalizations.of(context)!;
    return BaseWrapper(
      label:locale.promoCode,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CustomTextField(
            label: locale.enterPromoCode,
            hintText:locale.size20Per,
            hintStyle: TextStyle(color: Color(0xffA6A6A6)),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                context.maybePop();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.background, 
              ),
              child:  Text(
                locale.apply,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
