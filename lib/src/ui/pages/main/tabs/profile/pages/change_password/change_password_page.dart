import 'package:campuscravings/src/src.dart';

@RoutePage()
class ChangePasswordPage extends ConsumerWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = AppLocalizations.of(context)!;
    return BaseWrapper(
      label: locale.changePassword,
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            label: locale.enterOldPassword,
            textInputAction: TextInputAction.next,
            obscureText: true,
            onChanged: (value) {
              final currentState = ref.read(changePasswordProvider);
              ref.read(changePasswordProvider.notifier).state = {
                ...currentState,
                "old": value,
              };
            },
          ),
          CustomTextField(
            label: locale.enterNewPassword,
            obscureText: true,
            textInputAction: TextInputAction.next,
            onChanged: (value) {
              final currentState = ref.read(changePasswordProvider);
              ref.read(changePasswordProvider.notifier).state = {
                ...currentState,
                "new": value,
              };
            },
          ),
          CustomTextField(
            label: locale.confirmNewPassword,
            obscureText: true,
            onChanged: (value) {
              final currentState = ref.read(changePasswordProvider);
              ref.read(changePasswordProvider.notifier).state = {
                ...currentState,
                "confirm": value,
              };
            },
          ),
          height(24),
          Consumer(
            builder: (context, ref, child) {
              final password = ref.watch(changePasswordProvider);
              return RoundedButtonWidget(
                btnTitle: locale.save,
                onTap:
                    (password["new"]!.isNotEmpty &&
                                password["confirm"]!.isNotEmpty) &&
                            password["old"]!.isNotEmpty
                        ? () {
                          ref.read(newPasswordProvider.notifier).state = {
                            'old': '',
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

final changePasswordProvider = StateProvider<Map<String, String>>(
  (ref) => {"old": '', 'new': '', 'confirm': ''},
);
