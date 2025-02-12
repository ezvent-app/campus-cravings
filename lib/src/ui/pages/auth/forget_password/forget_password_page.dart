import 'package:campus_cravings/src/src.dart';

@RoutePage()
class ForgetPasswordPage extends StatelessWidget {
  ForgetPasswordPage({super.key});
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return BaseWrapper(
      label: "Forget Password",
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            controller: emailController,
            label: 'Enter Your Email',
          ),
          height(20),
          RoundedButtonWidget(
              btnTitle: locale.next,
              onTap: () => context.pushRoute(ForgetPasswordOTPRoute())),
        ],
      ),
    );
  }
}
