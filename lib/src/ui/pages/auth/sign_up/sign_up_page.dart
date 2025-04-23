import 'package:campuscravings/src/src.dart';

@RoutePage()
// ignore: must_be_immutable
class SignUpPage extends ConsumerWidget {
  SignUpPage({super.key});

  ValueNotifier<bool> setPassword = ValueNotifier<bool>(false);
  ValueNotifier<bool> confirmPassword = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    height(5),
                    Text(
                      locale.createAccount,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    height(20),
                    Text(
                      locale.selectUniversity,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    height(3),
                    DropDownWidget(
                      hintText: locale.selectUniversity,
                      universitiesList: ["Villanova University"],
                      onChange: (value) {
                        final university = ref.read(registerProvider);
                        ref.read(registerProvider.notifier).state = {
                          ...university,
                          'university': value,
                        };
                      },
                    ),
                    height(20),
                    CustomTextField(
                      label: locale.universityEmail,
                      textInputType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        final email = ref.read(registerProvider);
                        ref.read(registerProvider.notifier).state = {
                          ...email,
                          'email': value,
                        };
                      },
                    ),
                    height(20),
                    PasswordWidget(
                      password: setPassword,
                      passwordTitle: locale.setPassword,
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        final password = ref.read(registerProvider);
                        ref.read(registerProvider.notifier).state = {
                          ...password,
                          'password': value,
                        };
                      },
                    ),
                    height(20),
                    PasswordWidget(
                      password: confirmPassword,
                      passwordTitle: locale.confirmPassword,
                      onChanged: (value) {
                        final confirmPassword = ref.read(registerProvider);
                        ref.read(registerProvider.notifier).state = {
                          ...confirmPassword,
                          'confirmPassword': value,
                        };
                        print('fsdfdf: $confirmPassword');
                      },
                    ),
                    height(30),
                    Consumer(
                      builder: (context, ref, child) {
                        var register = ref.watch(registerProvider);
                        return RoundedButtonWidget(
                          btnTitle: locale.next,
                          onTap: () {
                            final passwordRegex = RegExp(
                              r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$',
                            );
                            final password = register['password']!;
                            final confirmPassword =
                                register['confirmPassword']!;
                            final email = register['email']!;
                            final university = register['university']!;

                            if (email.isEmpty) {
                              showToast(context: context, "Email is required");
                              return;
                            }

                            if (!email.contains('@')) {
                              showToast(
                                context: context,
                                "Email must include '@'",
                              );
                              return;
                            }
                            if (password.isEmpty) {
                              showToast(
                                context: context,
                                "Please enter a password",
                              );
                              return;
                            }

                            if (password.length < 6) {
                              showToast(
                                context: context,
                                "Password must be at least 6 characters",
                              );
                              return;
                            }

                            if (!passwordRegex.hasMatch(password)) {
                              showToast(
                                context: context,
                                "Password must contain at least one letter, one number, and one special character",
                              );
                              return;
                            }

                            if (password != confirmPassword) {
                              showToast(
                                context: context,
                                "Passwords do not match",
                              );
                              return;
                            }

                            context.pushRoute(
                              ProfileFormRoute(
                                newUser: true,
                                uniName: university,
                                email: email,
                                password: confirmPassword,
                              ),
                            );

                            // ref.read(registerProvider.notifier).state = {
                            //   'university': '',
                            //   'email': '',
                            //   'password': '',
                            //   'confirmPassword': '',
                            // };
                          },
                        );
                      },
                    ),
                    height(size.height * .05),
                    AccountInfoRowWidget(
                      title: locale.alreadyhaveAccount,
                      btnTitle: locale.logIn,
                      onTap: () => context.back(),
                    ),
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

final registerProvider = StateProvider<Map<String, String>>(
  (ref) => {
    'university': '',
    'email': '',
    'password': '',
    'confirmPassword': '',
  },
);
