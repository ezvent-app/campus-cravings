import 'package:campus_cravings/src/src.dart';

@RoutePage()
class ForgetPasswordOTPPage extends ConsumerWidget {
  const ForgetPasswordOTPPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = AppLocalizations.of(context)!;
    return BaseWrapper(
      label: locale.verification,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(locale.sendVerificationCode,
              style: Theme.of(context).textTheme.bodySmall),
          height(5),
          Text('sample@email.com',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontSize: 13, color: AppColors.black)),
          height(30),
          OtpPinField(
            maxLength: 6,
            otpPinFieldStyle: const OtpPinFieldStyle(
              filledFieldBorderColor: AppColors.otpPinColor,
              defaultFieldBorderColor: AppColors.otpPinBorderColor,
              filledFieldBackgroundColor: AppColors.otpPinColor,
              fieldBorderRadius: 8,
              fieldBorderWidth: 1,
              textStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: Dimensions.fontSizeExtraLarge),
            ),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            fieldWidth: 40,
            fieldHeight: 40,
            otpPinFieldDecoration: OtpPinFieldDecoration.custom,
            onSubmit: (text) {},
            onChange: (text) {},
          ),
          height(40),
          RoundedButtonWidget(
            btnTitle: locale.continueNext,
            onTap: () => context.pushRoute(NewPasswordRoute()),
          ),
          height(40),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${locale.getCodeIn} 04:30   ",
                  style: TextStyle(
                      fontSize: Dimensions.fontSizeSmall,
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightText),
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    locale.resend,
                    style: TextStyle(
                      fontSize: Dimensions.fontSizeSmall,
                      fontWeight: FontWeight.w600,
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
