import 'package:campuscravings/src/src.dart';
import 'package:campuscravings/src/utils/utils.dart';

@RoutePage()
class LoginPage extends ConsumerWidget {
  LoginPage({super.key});

  ValueNotifier<bool> password = ValueNotifier<bool>(false);
  HttpApiServices services = HttpApiServices();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final locale = AppLocalizations.of(context)!;
    HttpApiServices services = HttpApiServices();
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
                                  ? () async {
                                    try {
                                      final response = await services.postAPI(
                                        url: '/auth/login',
                                        map: {
                                          "username": loginNotifier['email'],
                                          "authMethod": "email",
                                          "verificationType": "password",
                                          "deviceType": "android",
                                          "deviceId":
                                              "dACC68I_SsOeP95zx5KyRc:APA91bGSili2JR9h6TnbhNUPoKeN1QsxDqpjOwNfJy_sCMgjhC-whoow8sOmXb-KlYbYZ_Qp8gl7c-EWTf1zK87rG8aWPHFmI7WuQ78qppVc_J9HJ7kagsnvDQg-5bFCtO0UJs2JZHHq",
                                          "password": loginNotifier['password'],
                                        },
                                      );

                                      final data = jsonDecode(response.body);
                                      if (response.statusCode == 201) {
                                        print("Navigating");
                                        if (context.mounted) {
                                          context.pushRoute(MainRoute());
                                        }
                                        final token =
                                            data['data']['accessToken'];
                                        final prefs =
                                            await SharedPreferences.getInstance();
                                        await prefs.setString(
                                          'accessToken',
                                          token,
                                        );

                                        ref.read(loginProvider.notifier).state =
                                            {'email': '', 'password': ''};
                                      } else {
                                        if (context.mounted) {
                                          if (data['message']
                                              .toString()
                                              .toLowerCase()
                                              .contains('not exist')) {
                                            ToastUtils.showToast(
                                              "User does not exist",
                                            );
                                          } else {
                                            ToastUtils.showToast(
                                              "Invalid credentials",
                                            );
                                          }
                                        }
                                      }
                                    } catch (e) {
                                      ToastUtils.showToast(
                                        "Login failed. Please try again.",
                                      );
                                    }
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
