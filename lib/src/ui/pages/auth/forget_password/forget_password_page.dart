import 'package:campus_cravings/src/src.dart';

@RoutePage()
class ForgetPasswordPage extends ConsumerWidget {
  ForgetPasswordPage({super.key});
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = AppLocalizations.of(context)!;

    return BaseWrapper(
      label: locale.forgetPassword,
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            controller: emailController,
            label: locale.enterYourEmail,
            onChanged: (value) =>
                ref.read(forgetPasswordProvider.notifier).state = value,
          ),
          height(20),
          Consumer(
            builder: (context, ref, child) {
              var passwordProvider = ref.watch(forgetPasswordProvider);
              return RoundedButtonWidget(
                  btnTitle: locale.next,
                  onTap: passwordProvider.isNotEmpty
                      ? () {
                          context.pushRoute(ForgetPasswordOTPRoute());
                          ref.read(forgetPasswordProvider.notifier).state = '';
                        }
                      : null);
            },
          )
        ],
      ),
    );
  }
}

final forgetPasswordProvider = StateProvider<String>((ref) => '');
