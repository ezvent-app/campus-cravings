import 'package:campuscravings/src/src.dart';

@RoutePage()
// ignore: must_be_immutable
class LoginPage extends ConsumerWidget {
  LoginPage({super.key});

  ValueNotifier<bool> password = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    height(5),
                    Text(
                      locale.enterEmailAndPassword,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    height(20),
                    CustomTextField(
                      label: locale.universityEmail,
                      textInputType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        final email = ref.read(loginProvider);
                        ref.read(loginProvider.notifier).state = {
                          ...email,
                          'email': value,
                        };
                      },
                    ),
                    height(20),
                    PasswordWidget(
                      password: password,
                      passwordTitle: locale.confirmPassword,
                      onChanged: (value) {
                        final password = ref.read(loginProvider);
                        ref.read(loginProvider.notifier).state = {
                          ...password,
                          'password': value,
                        };
                      },
                    ),
                    height(5),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed:
                            () => context.pushRoute(ForgetPasswordRoute()),
                        child: Text(
                          locale.forgotPassword,
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(color: AppColors.accent),
                        ),
                      ),
                    ),
                    height(20),
                    Consumer(
                      builder: (context, ref, child) {
                        var loginNotifier = ref.watch(loginProvider);
                        return RoundedButtonWidget(
                          btnTitle: locale.logIn,
                          onTap:
                              loginNotifier['email']!.isNotEmpty &&
                                      loginNotifier['password']!.isNotEmpty
                                  ? () {
                                    context.pushRoute(const MainRoute());
                                    ref.read(loginProvider.notifier).state = {
                                      'email': '',
                                      'password': '',
                                    };
                                  }
                                  : null,
                        );
                      },
                    ),
                    height(size.height * .12),
                    AccountInfoRowWidget(
                      title: locale.dontHaveAccount,
                      btnTitle: locale.signUp,
                      onTap: () => context.pushRoute(SignUpRoute()),
                    ),
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

final loginProvider = StateProvider<Map<String, String>>(
  (ref) => {'email': '', 'password': ''},
);
