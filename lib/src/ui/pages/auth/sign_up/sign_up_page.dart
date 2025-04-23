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
      appBar: AppBar(toolbarHeight: 10),
      body: SingleChildScrollView(
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
                    universitiesList: [
                      "Villanova University",
                      "Stanford University",
                      "Harvard University",
                      "Yale University",
                    ],
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
                    },
                  ),
                  height(30),
                  Consumer(
                    builder: (context, ref, child) {
                      var register = ref.watch(registerProvider);
                      return RoundedButtonWidget(
                        btnTitle: locale.register,
                        onTap:
                            register['university']!.isNotEmpty &&
                                    register['email']!.isNotEmpty &&
                                    register['password']!.isNotEmpty &&
                                    register['confirmPassword']!.isNotEmpty
                                ? () {
                                  context.pushRoute(
                                    ProfileFormRoute(newUser: true),
                                  );
                                  ref.read(registerProvider.notifier).state = {
                                    'university': '',
                                    'email': '',
                                    'password': '',
                                    'confirmPassword': '',
                                  };
                                }
                                : null,
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
