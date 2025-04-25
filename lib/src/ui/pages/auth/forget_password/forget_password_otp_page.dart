import 'dart:async';

import 'package:campuscravings/src/constants/storageHelper.dart';
import 'package:campuscravings/src/src.dart';

@RoutePage()
class ForgetPasswordOTPPage extends ConsumerStatefulWidget {
  final String email;
  const ForgetPasswordOTPPage({super.key, required this.email});

  @override
  ConsumerState<ForgetPasswordOTPPage> createState() =>
      _ForgetPasswordOTPPageState();
}

class _ForgetPasswordOTPPageState extends ConsumerState<ForgetPasswordOTPPage> {
  late HttpAPIServices services;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(otpNotifierProvider.notifier).resetState();
    });
    services = HttpAPIServices();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final otpState = ref.watch(otpNotifierProvider);

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
            widget.email,
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
            onSubmit:
                (text) =>
                    ref.read(otpNotifierProvider.notifier).updateOtp(text),
            onChange:
                (text) =>
                    ref.read(otpNotifierProvider.notifier).updateOtp(text),
          ),
          height(40),
          Consumer(
            builder: (context, ref, child) {
              final otpState = ref.watch(otpNotifierProvider);
              return RoundedButtonWidget(
                isLoading: otpState.isLoading,
                btnTitle: locale.continueNext,
                onTap:
                    otpState.otp.length != 4
                        ? null
                        : () async {
                          ref
                              .read(otpNotifierProvider.notifier)
                              .setLoading(true);
                          try {
                            final response = await services.postAPI(
                              url: '/auth/verifyOTP',
                              map: {
                                "userId": StorageHelper().getUserId(),
                                "activationCode": otpState.otp,
                                "deviceType":
                                    Platform.isAndroid ? "android" : "ios",
                                "deviceId":
                                    "dACC68I_SsOeP95zx5KyRc:APA91bGSili2JR9h6TnbhNUPoKeN1QsxDqpjOwNfJy_sCMgjhC-whoow8sOmXb-KlYbYZ_Qp8gl7c-EWTf1zK87rG8aWPHFmI7WuQ78qppVc_J9HJ7kagsnvDQg-5bFCtO0UJs2JZHHq",
                              },
                            );

                            if (response.statusCode == 200) {
                              if (context.mounted) {
                                context.pushRoute(NewPasswordRoute());
                                showToast(
                                  "Verification successful!",
                                  context: context,
                                );
                              }
                            } else {
                              showToast(
                                "Verification failed. Please try again.",
                                context: context,
                              );
                            }
                          } catch (e) {
                            showToast(
                              "Please try again later!",
                              context: context,
                            );
                          } finally {
                            ref
                                .read(otpNotifierProvider.notifier)
                                .setLoading(false);
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
                  "${locale.getCodeIn} ${ref.read(otpNotifierProvider.notifier).getFormattedTime()}   ",
                  style: TextStyle(
                    fontSize: Dimensions.fontSizeSmall,
                    fontWeight: FontWeight.w500,
                    color: AppColors.lightText,
                  ),
                ),
                InkWellButtonWidget(
                  onTap:
                      otpState.canResend
                          ? () => ref
                              .read(otpNotifierProvider.notifier)
                              .resendOtp(context)
                          : null,
                  child: Text(
                    locale.resend,
                    style: TextStyle(
                      fontSize: Dimensions.fontSizeSmall,
                      fontWeight: FontWeight.w600,
                      color:
                          otpState.canResend
                              ? AppColors.black
                              : AppColors.lightText,
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

final otpNotifierProvider = StateNotifierProvider<OtpNotifier, OtpState>(
  (ref) => OtpNotifier(),
);

// Define OtpState class
class OtpState {
  final String otp;
  final int remainingSeconds;
  final bool canResend;
  final bool isLoading;

  OtpState({
    required this.otp,
    required this.remainingSeconds,
    required this.canResend,
    this.isLoading = false,
  });

  OtpState copyWith({
    String? otp,
    int? remainingSeconds,
    bool? canResend,
    bool? isLoading,
  }) {
    return OtpState(
      otp: otp ?? this.otp,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      canResend: canResend ?? this.canResend,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class OtpNotifier extends StateNotifier<OtpState> {
  Timer? _timer;

  OtpNotifier()
    : super(
        OtpState(
          otp: '',
          remainingSeconds: 180, // 4 minutes 30 seconds
          canResend: false,
        ),
      ) {
    _startTimer();
  }

  // Update OTP input
  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  // Update OTP input
  void updateOtp(String newOtp) {
    state = state.copyWith(otp: newOtp);
  }

  // Start or restart the countdown timer
  void _startTimer() {
    _timer?.cancel(); // Cancel any existing timer
    state = state.copyWith(remainingSeconds: 180, canResend: false);

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (state.remainingSeconds > 0) {
        state = state.copyWith(remainingSeconds: state.remainingSeconds - 1);
      } else {
        state = state.copyWith(canResend: true);
        timer.cancel();
      }
    });
  }

  // Format remaining time as mm:ss
  String getFormattedTime() {
    int minutes = state.remainingSeconds ~/ 60;
    int seconds = state.remainingSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  // Handle resend action
  Future<void> resendOtp(BuildContext context) async {
    HttpAPIServices services = HttpAPIServices();
    if (state.canResend) {
      _startTimer(); // Restart timer
      try {
        final response = await services.postAPI(
          url: '/auth/resendOTP',
          map: {
            "userId": StorageHelper().getUserId(),
            "authMethod": "email",
            "deviceType": Platform.isAndroid ? "android" : "ios",
          },
        );

        if (response.statusCode == 200) {
          if (context.mounted) {
            showToast("Otp has been re-sent to your email", context: context);
          }
        } else {
          print("Error: ${response.statusCode}");
        }
      } catch (e) {
        print("Error: $e");
      }
    }
  }

  void resetState() {
    _timer?.cancel();
    state = OtpState(
      otp: '',
      remainingSeconds: 180,
      canResend: false,
      isLoading: false,
    );
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel(); // Clean up timer
    super.dispose();
  }
}
