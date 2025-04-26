import 'package:campuscravings/src/constants/storageHelper.dart';
import 'package:campuscravings/src/src.dart';

@RoutePage()
class ChangePasswordPage extends ConsumerWidget {
  ChangePasswordPage({super.key});
  ValueNotifier<bool> oldPassword = ValueNotifier<bool>(false);
  ValueNotifier<bool> setPassword = ValueNotifier<bool>(false);
  ValueNotifier<bool> confirmPassword = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = AppLocalizations.of(context)!;
    HttpAPIServices services = HttpAPIServices();
    return BaseWrapper(
      label: locale.changePassword,
      child: SingleChildScrollView(
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
                  "old": value,
                };
              },
              password: oldPassword,
              passwordTitle: locale.enterOldPassword,
            ),
            PasswordWidget(
              onChanged: (value) {
                final currentState = ref.read(newPasswordProvider);
                ref.read(newPasswordProvider.notifier).state = {
                  ...currentState,
                  "new": value,
                };
              },
              password: setPassword,
              passwordTitle: locale.newPassword,
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
              passwordTitle: locale.confirmNewPassword,
            ),
            height(200),
            Consumer(
              builder: (context, ref, child) {
                var newPasswordState = ref.watch(newPasswordProvider);
                final userID = StorageHelper().getUserId();
                return RoundedButtonWidget(
                  btnTitle: locale.save,
                  onTap:
                      (newPasswordState["old"]!.isNotEmpty &&
                              newPasswordState["new"]!.isNotEmpty &&
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
                                url: '/auth/resetPassword/$userID',
                                map: {
                                  "oldPassword": newPasswordState['old'],
                                  "password": newPasswordState['confirm'],
                                },
                              );

                              final data = jsonDecode(response.body);

                              if (response.statusCode == 200) {
                                if (context.mounted) {
                                  Navigator.of(context).pop();
                                  ref.read(newPasswordProvider.notifier).state =
                                      {'new': '', 'old': '', 'confirm': ''};
                                  showToast(
                                    "Password changed successfully!",
                                    context: context,
                                  );
                                }

                                print('Response: $data');
                              }
                              if (response.statusCode == 400) {
                                showToast(
                                  context: context,
                                  "Old password is incorrect!",
                                );
                              } else {
                                // showToast(
                                //   context: context,
                                //   "An unknown error occurred.",
                                // );
                              }
                            } catch (e) {
                              showToast(
                                "something went wrong. Please try again.",
                              );
                            }
                          }
                          : () {},
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

final newPasswordProvider = StateProvider<Map<String, String>>(
  (ref) => {"old": '', "new": '', 'confirm': ''},
);
