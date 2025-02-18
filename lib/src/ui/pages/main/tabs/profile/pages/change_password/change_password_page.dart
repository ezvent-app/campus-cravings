import 'package:campus_cravings/src/src.dart';

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
            obscureText: true,
          ),
          CustomTextField(
            label: locale.enterNewPassword,
            obscureText: true,
          ),
          CustomTextField(
            label: locale.confirmNewPassword,
            obscureText: true,
          ),
        ],
      ),
    );
  }
}
