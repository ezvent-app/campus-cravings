import 'package:campuscravings/src/constants/storageHelper.dart';
import 'package:campuscravings/src/src.dart';

@RoutePage()
class LoginPage extends ConsumerWidget {
  LoginPage({super.key});

  ValueNotifier<bool> password = ValueNotifier<bool>(false);
  HttpAPIServices services = HttpAPIServices();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final locale = AppLocalizations.of(context)!;
    HttpAPIServices services = HttpAPIServices();
    final socketController = ref.read(socketControllerProvider);
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
                        final loginState = ref.read(loginProvider);
                        ref.read(loginProvider.notifier).state = {
                          ...loginState,
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
                          isLoading: loginNotifier['isLoading'] ?? false,
                          onTap:
                              loginNotifier['email']!.isNotEmpty &&
                                      loginNotifier['password']!.isNotEmpty
                                  ? () async {
                                    if (!loginNotifier['email']!.contains(
                                      '@',
                                    )) {
                                      showToast(
                                        context: context,
                                        "Please enter a valid email",
                                      );
                                      return;
                                    }
                                    ref.read(loginProvider.notifier).state = {
                                      ...loginNotifier,
                                      'isLoading': true,
                                    };
                                    try {
                                      final response = await services.postAPI(
                                        url: '/auth/login',
                                        map: {
                                          "username": loginNotifier['email'],
                                          "authMethod": "email",
                                          "verificationType": "password",
                                          "deviceType":
                                              Platform.isAndroid
                                                  ? "android"
                                                  : "ios",
                                          "deviceId":
                                              "dACC68I_SsOeP95zx5KyRc:APA91bGSili2JR9h6TnbhNUPoKeN1QsxDqpjOwNfJy_sCMgjhC-whoow8sOmXb-KlYbYZ_Qp8gl7c-EWTf1zK87rG8aWPHFmI7WuQ78qppVc_J9HJ7kagsnvDQg-5bFCtO0UJs2JZHHq",
                                          "password": loginNotifier['password'],
                                        },
                                      );

                                      final data = jsonDecode(response.body);
                                      if (response.statusCode == 201) {
                                        if (context.mounted) {
                                          context.pushRoute(MainRoute());
                                        }
                                        final token =
                                            data['user']['accessToken'];
                                        StorageHelper().saveAccessToken(token);

                                        final token1 =
                                            StorageHelper().getAccessToken();
                                        final isRider =
                                            data['user']['isDelivery'];
                                        StorageHelper()
                                            .saveRiderProfileComplete(isRider);

                                        print('Storge Token: $token1');

                                        print('tokeen: $token');
                                        final socketController = ref.read(
                                          socketControllerProvider,
                                        );
                                        socketController.connect(token);

                                        ref.read(loginProvider.notifier).state =
                                            {'email': '', 'password': ''};
                                      } else if (response.statusCode == 400) {
                                        showToast(
                                          context: context,
                                          "Invalid email or password",
                                        );
                                      } else if (response.statusCode == 500) {
                                        showToast(
                                          context: context,
                                          "Invalid email or password", //basically its an Server error. noted even if password is wrong and charchter are greater then 7 then it retrun server error which not should be so for time being hardcoded it to invalid email or password
                                        );
                                      } else {
                                        showToast(
                                          context: context,
                                          "An unknown error occurred.",
                                        );
                                      }
                                    } catch (e) {
                                      showToast(
                                        "Login failed. Please try again.",
                                      );
                                    } finally {
                                      ref.read(loginProvider.notifier).state = {
                                        ...loginNotifier,
                                        'isLoading': false,
                                      };
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

final loginProvider = StateProvider<Map<String, dynamic>>(
  (ref) => {'email': '', 'password': '', 'loading': false},
);
