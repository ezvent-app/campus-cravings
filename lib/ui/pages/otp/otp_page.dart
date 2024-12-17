import 'package:auto_route/auto_route.dart';
import 'package:campus_cravings/constants/app_colors.dart';
import 'package:campus_cravings/router/router.gr.dart';
import 'package:campus_cravings/ui/widgets/base_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

@RoutePage()
class OtpPage extends ConsumerStatefulWidget {
  const OtpPage({super.key});

  @override
  ConsumerState createState() => _OtpPageState();
}

class _OtpPageState extends ConsumerState<OtpPage> {
  @override
  Widget build(BuildContext context) {
    return BaseWrapper(
      label: 'Verification',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "We've send you the verification code on",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: AppColors.lightText,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'sample@email.com',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 30),
          OtpPinField(
            maxLength: 6,
            otpPinFieldStyle: const OtpPinFieldStyle(
              filledFieldBorderColor: AppColors.otpPinColor,
              defaultFieldBorderColor: AppColors.otpPinBorderColor,
              filledFieldBackgroundColor: AppColors.otpPinColor,
              fieldBorderRadius: 8,
              fieldBorderWidth: 1,
              textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            fieldWidth: 45,
            fieldHeight: 45,
            otpPinFieldDecoration: OtpPinFieldDecoration.custom,
            onSubmit: (text) {},
            onChange: (text) {},
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: (){
                context.pushRoute(ProfileFormRoute(newUser: true));
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.background,// Splash color
              ),
              child: const Text(
                'Continue',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Get code in 04:30   ",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightText
                  ),
                ),
                GestureDetector(
                  onTap: (){},
                  child: const Text(
                    "Resend",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}