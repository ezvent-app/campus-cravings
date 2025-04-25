import 'package:campuscravings/src/constants/storageHelper.dart';
import 'package:campuscravings/src/src.dart';

@RoutePage()
class NewPasswordPage extends ConsumerWidget {
  NewPasswordPage({super.key});

  ValueNotifier<bool> setPassword = ValueNotifier<bool>(false);
  ValueNotifier<bool> confirmPassword = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = AppLocalizations.of(context)!;
    HttpAPIServices services = HttpAPIServices();
    return BaseWrapper(
      label: locale.newPassword,
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PasswordWidget(
            textInputAction: TextInputAction.next,
            onChanged: (value) {
              final currentState = ref.read(newPasswordProvider);
              ref.read(newPasswordProvider.notifier).state = {
                ...currentState,
                "new": value,
              };
            },
            password: setPassword,
            passwordTitle: locale.enterNewPassword,
          ),
          PasswordWidget(
            onChanged: (value) {
              final currentState = ref.read(newPasswordProvider);
              ref.read(newPasswordProvider.notifier).state = {
                ...currentState,
                "confirm": value,
              };
            },
            password: confirmPassword,
            passwordTitle: locale.reEnterPassword,
          ),
          Consumer(
            builder: (context, ref, child) {
              var newPasswordState = ref.watch(newPasswordProvider);
              final userID = StorageHelper().getUserId();
              return RoundedButtonWidget(
                btnTitle: locale.save,
                onTap:
                    (newPasswordState["new"]!.isNotEmpty &&
                            newPasswordState["confirm"]!.isNotEmpty)
                        ? () async {
                          print('passsword: $newPasswordState[confirm]');
                          final passwordRegex = RegExp(
                            r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$',
                          );

                          if (newPasswordState['new']!.length < 6 ||
                              newPasswordState['confirm']!.length < 6) {
                            showToast(
                              context: context,
                              "Password must be at least 6 characters",
                            );
                            return;
                          }
                          if (newPasswordState["new"] !=
                              newPasswordState["confirm"]) {
                            showToast(
                              context: context,
                              "Password does not match",
                            );
                            return;
                          }
                          if (!passwordRegex.hasMatch(
                            newPasswordState["new"]!,
                          )) {
                            showToast(
                              context: context,
                              "Password must contain at least one letter, one number, and one special character",
                            );
                            return;
                          }

                          try {
                            final response = await services.postAPI(
                              url: '/auth/resetPasswordOTP/$userID',
                              map: {"password": newPasswordState['confirm']},
                            );

                            final data = jsonDecode(response.body);

                            if (response.statusCode == 200) {
                              if (context.mounted) {
                                context.replaceRoute(LoginRoute());
                                ref.read(newPasswordProvider.notifier).state = {
                                  'new': '',
                                  'confirm': '',
                                };
                                showToast(
                                  "Password changed successfully!",
                                  context: context,
                                );
                              }

                              print('Response: $data');
                            } else {
                              showToast(
                                context: context,
                                "An unknown error occurred.",
                              );
                            }
                          } catch (e) {
                            showToast(
                              "something went wrong. Please try again.",
                            );
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

final newPasswordProvider = StateProvider<Map<String, String>>(
  (ref) => {"new": '', 'confirm': ''},
);
