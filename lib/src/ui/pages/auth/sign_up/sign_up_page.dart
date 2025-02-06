import 'package:campus_cravings/src/src.dart';

@RoutePage()
// ignore: must_be_immutable
class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  ValueNotifier<bool> setPassword = ValueNotifier<bool>(false);
  ValueNotifier<bool> confirmPassword = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PngAsset(
                Images.loginHeader,
                width: size.width,
                height: size.height * .18,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    height(3),
                    Text(
                      locale.signUp,
                      style: TextStyle(
                          fontSize: Dimensions.fontSizeMoreOverLarge,
                          fontWeight: FontWeight.w700),
                    ),
                    height(5),
                    Text(
                      locale.createAccount,
                      style: TextStyle(
                        fontSize: Dimensions.fontSizeSmall,
                        color: AppColors.lightText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    height(20),
                    Text(
                      locale.selectUniversity,
                      style: const TextStyle(
                        fontSize: Dimensions.fontSizeSmall,
                        color: AppColors.lightText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    height(3),
                    UniversityDropDownWidget(
                      universitiesList: ["Villanova University"],
                      onChange: (value) {},
                    ),
                    height(20),
                    CustomTextField(
                      label: locale.universityEmail,
                    ),
                    height(20),
                    PasswordWidget(
                        password: setPassword,
                        passwordTitle: locale.setPassword),
                    height(20),
                    PasswordWidget(
                        password: confirmPassword,
                        passwordTitle: locale.confirmPassword),
                    height(30),
                    RoundedButtonWidget(
                      btnTitle: locale.register,
                      onTap: () => context.pushRoute(const OtpRoute()),
                    ),
                    height(size.height * .05),
                    AccountInfoRowWidget(
                        title: locale.alreadyhaveAccount,
                        btnTitle: locale.logIn,
                        onTap: () => context.back())
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
