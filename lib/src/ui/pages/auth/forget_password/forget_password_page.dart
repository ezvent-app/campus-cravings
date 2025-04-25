import 'package:campuscravings/src/constants/storageHelper.dart';
import 'package:campuscravings/src/src.dart';

@RoutePage()
class ForgetPasswordPage extends ConsumerWidget {
  ForgetPasswordPage({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = AppLocalizations.of(context)!;
    final HttpAPIServices services = HttpAPIServices();

    return BaseWrapper(
      label: locale.forgetPassword,
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            controller: emailController,
            label: locale.enterYourEmail,
            onChanged: (value) {
              final currentState = ref.read(forgetPasswordProvider);
              ref.read(forgetPasswordProvider.notifier).state = {
                ...currentState,
                'email': value,
              };
            },
          ),
          height(20),
          Consumer(
            builder: (context, ref, child) {
              final forgotPasswordState = ref.watch(forgetPasswordProvider);

              return RoundedButtonWidget(
                btnTitle: locale.logIn,
                isLoading: forgotPasswordState['isLoading'] ?? false,
                onTap:
                    forgotPasswordState['email'] != null &&
                            forgotPasswordState['email'].toString().isNotEmpty
                        ? () async {
                          if (!forgotPasswordState['email'].toString().contains(
                            '@',
                          )) {
                            showToast(
                              context: context,
                              "Please enter a valid email",
                            );
                            return;
                          }

                          ref.read(forgetPasswordProvider.notifier).state = {
                            ...forgotPasswordState,
                            'isLoading': true,
                          };

                          try {
                            final response = await services.postAPI(
                              url: '/auth/forgotPassword',
                              map: {
                                // "deviceType":
                                //     Platform.isAndroid ? "android" : "ios",
                                "email": forgotPasswordState['email'],
                                "authMethod": "email",
                                // "deviceId":
                                //     "dACC68I_SsOeP95zx5KyRc:APA91bGSili2JR9h6TnbhNUPoKeN1QsxDqpjOwNfJy_sCMgjhC-whoow8sOmXb-KlYbYZ_Qp8gl7c-EWTf1zK87rG8aWPHFmI7WuQ78qppVc_J9HJ7kagsnvDQg-5bFCtO0UJs2JZHHq",
                              },
                            );

                            final data = jsonDecode(response.body);

                            if (response.statusCode == 200) {
                              if (context.mounted) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) => ForgetPasswordOTPPage(
                                          email: forgotPasswordState['email'],
                                        ),
                                  ),
                                );
                                showToast(
                                  "Otp has been sent to your email",
                                  context: context,
                                );
                              }
                              final userId = data['result']['_id'];
                              StorageHelper().saveUserId(userId);

                              print('Response: $data');

                              ref
                                  .read(forgetPasswordProvider.notifier)
                                  .state = {'email': '', 'isLoading': false};
                            } else if (response.statusCode == 401) {
                              showToast(
                                context: context,
                                "Please enter registered email address",
                              );
                            } else if (response.statusCode == 500) {
                              showToast(context: context, "Invalid email");
                            } else {
                              showToast(
                                context: context,
                                "An unknown error occurred.",
                              );
                            }
                          } catch (e) {
                            showToast("Login failed. Please try again.");
                          } finally {
                            ref.read(forgetPasswordProvider.notifier).state = {
                              ...forgotPasswordState,
                              'isLoading': false,
                            };
                          }
                        }
                        : null,
              );
            },
          ),
        ],
      ),
    );
  }
}

// State provider to hold email and loading state
final forgetPasswordProvider = StateProvider<Map<String, dynamic>>(
  (ref) => {"email": "", "isLoading": false},
);
