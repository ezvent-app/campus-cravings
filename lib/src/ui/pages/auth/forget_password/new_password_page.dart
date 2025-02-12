import 'package:campus_cravings/src/src.dart';

@RoutePage()
class NewPasswordPage extends StatelessWidget {
  const NewPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return BaseWrapper(
      label: 'New Password',
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            label: 'Enter New Password',
            obscureText: true,
          ),
          CustomTextField(
            label: 'Re-enter Password',
            obscureText: true,
          ),
          RoundedButtonWidget(btnTitle: locale.save, onTap: () {}),
        ],
      ),
    );
  }
}
