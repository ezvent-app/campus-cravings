import 'package:campuscravings/src/constants/storageHelper.dart';
import 'package:campuscravings/src/src.dart';

@RoutePage()
class OtpPage extends ConsumerWidget {
  final bool isRyder;
  final String? email;
  const OtpPage({this.email, super.key, required this.isRyder});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = AppLocalizations.of(context)!;
    HttpApiServices services = HttpApiServices();
    return BaseWrapper(
      label: locale.verification,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            locale.sendVerificationCode,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          height(5),
          Text(
            email ?? "testingdev131@gmail.com",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 13,
              color: AppColors.black,
            ),
          ),
          height(30),
          OtpPinField(
            maxLength: 4,
            otpPinFieldStyle: const OtpPinFieldStyle(
              filledFieldBorderColor: AppColors.otpPinColor,
              defaultFieldBorderColor: AppColors.otpPinBorderColor,
              filledFieldBackgroundColor: AppColors.otpPinColor,
              fieldBorderRadius: 8,
              fieldBorderWidth: 1,
              textStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Dimensions.fontSizeExtraLarge,
              ),
            ),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            fieldWidth: 40,
            fieldHeight: 40,
            otpPinFieldDecoration: OtpPinFieldDecoration.custom,
            onSubmit: (text) => ref.read(otpProvider.notifier).state = text,
            onChange: (text) => ref.read(otpProvider.notifier).state = text,
          ),
          height(40),
          Consumer(
            builder: (context, ref, child) {
              final otp = ref.watch(otpProvider);
              return RoundedButtonWidget(
                btnTitle: locale.continueNext,
                onTap:
                    otp.length != 4
                        ? null
                        : isRyder
                        ? () => context.pushRoute(StudentProfileDetailsRoute())
                        : () async {
                          try {
                            print('otp: $otp');
                            final response = await services.postAPI(
                              url: '/auth/verifyOTP',
                              map: {
                                "userId": StorageHelper().getUserId(),
                                "activationCode": otp,
                                "deviceType":
                                    Platform.isAndroid ? "android" : "ios",
                                "deviceId":
                                    "dACC68I_SsOeP95zx5KyRc:APA91bGSili2JR9h6TnbhNUPoKeN1QsxDqpjOwNfJy_sCMgjhC-whoow8sOmXb-KlYbYZ_Qp8gl7c-EWTf1zK87rG8aWPHFmI7WuQ78qppVc_J9HJ7kagsnvDQg-5bFCtO0UJs2JZHHq",
                              },
                            );
                            final data = jsonDecode(response.body);
                            if (response.statusCode == 200) {
                              if (context.mounted) {
                                context.pushRoute(MainRoute());
                              }
                              final token = data['user']['accessToken'];
                              StorageHelper().saveAccessToken(token);
                            }
                          } catch (e) {
                            showToast("Please try again later!");
                          }
                        },
              );
            },
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
                    color: AppColors.lightText,
                  ),
                ),
                InkWellButtonWidget(
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
          ),
        ],
      ),
    );
  }
}

final otpProvider = StateProvider<String>((ref) => '');
