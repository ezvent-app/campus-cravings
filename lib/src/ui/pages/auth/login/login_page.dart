import 'package:campus_cravings/src/src.dart';

@RoutePage()
// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  ValueNotifier<bool> password = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PngAsset(
              Images.loginHeader,
              width: size.width,
              height: size.height * .18,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    height(3),
                    Text(
                      locale.signIntoAccount,
                      style: TextStyle(
                          fontSize: Dimensions.fontSizeMoreOverLarge,
                          fontWeight: FontWeight.w700),
                    ),
                    height(5),
                    Text(
                      locale.enterEmailAndPassword,
                      style: TextStyle(
                        fontSize: Dimensions.fontSizeSmall,
                        color: AppColors.lightText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    height(20),
                    CustomTextField(
                      label: locale.universityEmail,
                    ),
                    height(20),
                    PasswordWidget(
                        password: password,
                        passwordTitle: locale.confirmPassword),
                    height(5),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          locale.forgotPassword,
                          style: TextStyle(
                              fontSize: Dimensions.fontSizeSmall,
                              fontWeight: FontWeight.w500,
                              color: AppColors.accent),
                        ),
                      ),
                    ),
                    height(20),
                    RoundedButtonWidget(
                      btnTitle: locale.logIn,
                      onTap: () => context.pushRoute(const MainRoute()),
                    ),
                    height(size.height * .12),
                    AccountInfoRowWidget(
                        title: locale.dontHaveAccount,
                        btnTitle: locale.signUp,
                        onTap: () => context.pushRoute(const SignUpRoute()))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
