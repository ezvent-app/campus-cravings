

import 'package:campus_cravings/src/src.dart';

@RoutePage()
class PromoCodePage extends ConsumerStatefulWidget {
  const PromoCodePage({super.key});

  @override
  ConsumerState createState() => _PromoCodePageState();
}

class _PromoCodePageState extends ConsumerState<PromoCodePage> {
  @override
  Widget build(BuildContext context) {
    return BaseWrapper(
      label: "Promo Code",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(
            label: "Enter Promo Code",
            hintText: 'E.g 20%DIS',
            hintStyle: TextStyle(
                color: Color(0xffA6A6A6)
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: (){
                context.maybePop();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.background,// Splash color
              ),
              child: const Text(
                'Apply',
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