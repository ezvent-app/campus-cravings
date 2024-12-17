import 'package:auto_route/auto_route.dart';
import 'package:campus_cravings/constants/app_colors.dart';
import 'package:campus_cravings/router/router.gr.dart';
import 'package:campus_cravings/ui/widgets/base_wrapper.dart';
import 'package:campus_cravings/ui/widgets/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class DeliverySetupPage extends ConsumerStatefulWidget {
  const DeliverySetupPage({super.key});

  @override
  ConsumerState createState() => _DeliverySetupPageState();
}

class _DeliverySetupPageState extends ConsumerState<DeliverySetupPage> {
  @override
  Widget build(BuildContext context) {
    return BaseWrapper(
      label: 'Delivery Set-up',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextField(label: 'Enter Social Security Number'),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.only(bottom: 3),
            child: Text(
              'National ID / Proof of Work Permission',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.lightText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          OutlinedButton(
            onPressed: (){},
            style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                foregroundColor: const Color(0xff525252)
            ),
            child: const Text('Upload Or Capture Image'),
          ),
          Row(
            children: [
              Transform.scale(
                scale: 1.3,
                child: Checkbox(
                  value: false,
                  onChanged: (value) {
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  side: WidgetStateBorderSide.resolveWith(
                        (states) => const BorderSide(width: 1.0, color: Colors.grey),
                  ),
                ),
              ),
              const Text(
                'I agree with ',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff6C7278)
                ),
              ),
              GestureDetector(
                onTap: (){},
                child: const Text(
                  'Terms and Conditions',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff070707),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: 'Disclaimer: ',
                  style: TextStyle(
                    fontFamily: 'SofiaPro',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                const TextSpan(
                  text: 'Your Social Security Number and ID are required for background checks, work eligibility verification, and compliance with legal regulations, and will be securely stored as per our ',
                  style: TextStyle(
                    fontFamily: 'SofiaPro',
                    fontSize: 13,
                    height: 1.5,
                    color: Color(0xFF979797),
                  ),
                ),
                TextSpan(
                  text: 'Privacy Policy',
                  style: const TextStyle(
                      fontFamily: 'SofiaPro',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                      decoration: TextDecoration.underline
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                    },
                ),
                const TextSpan(
                  text: '.',
                  style: TextStyle(
                    fontFamily: 'SofiaPro',
                    fontSize: 13,
                    height: 1.5,
                    color: Color(0xFF979797),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: (){
                context.pushRoute(const AddPayoutRoute());
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.background,// Splash color
              ),
              child: const Text(
                'Next',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );

  }
}