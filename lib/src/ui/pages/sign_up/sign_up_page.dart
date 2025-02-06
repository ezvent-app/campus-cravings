import 'package:campus_cravings/src/src.dart';

@RoutePage()
class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  bool _showSetPassword = false;
  bool _showConfirmPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PngAsset('login_header'),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 3),
                    const Text(
                      'Sign Up',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Create an account to continue!',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.lightText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 32),
                    const CustomTextField(label: 'University Email'),
                    const SizedBox(height: 32),
                    const CustomTextField(
                      label: 'Full Name',
                    ),
                    const SizedBox(height: 32),
                    CustomTextField(
                      label: 'Set Password',
                      obscureText: !_showSetPassword,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _showSetPassword = !_showSetPassword;
                          });
                        },
                        icon: Icon(
                          _showSetPassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    CustomTextField(
                      label: 'Confirm Password',
                      obscureText: !_showConfirmPassword,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _showConfirmPassword = !_showConfirmPassword;
                          });
                        },
                        icon: Icon(
                          _showConfirmPassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          context.pushRoute(const OtpRoute());
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.background, // Splash color
                        ),
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
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
