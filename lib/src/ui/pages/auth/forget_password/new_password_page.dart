import 'package:campuscravings/src/src.dart';

@RoutePage()
class NewPasswordPage extends ConsumerWidget {
  NewPasswordPage({super.key});

  ValueNotifier<bool> setPassword = ValueNotifier<bool>(false);
  ValueNotifier<bool> confirmPassword = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = AppLocalizations.of(context)!;

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
              return RoundedButtonWidget(
                btnTitle: locale.save,
                onTap:
                    (newPasswordState["new"]!.isNotEmpty &&
                            newPasswordState["confirm"]!.isNotEmpty)
                        ? () {
                          context.replaceRoute(LoginRoute());
                          ref.read(newPasswordProvider.notifier).state = {
                            'new': '',
                            'confirm': '',
                          };
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
