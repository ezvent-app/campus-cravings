import 'package:auto_route/auto_route.dart';
import 'package:campus_cravings/constants/app_colors.dart';
import 'package:campus_cravings/router/router.gr.dart';
import 'package:campus_cravings/ui/widgets/custom_text_field.dart';
import 'package:campus_cravings/ui/widgets/png_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  bool _showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PngAsset('login_header'),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 3),
                    const Text(
                      'Sign in to your Account',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Enter your email and password to log in',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.lightText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 32),
                    const CustomTextField(label: 'University Email',),
                    const SizedBox(height: 32),
                    CustomTextField(
                      label: 'Password',
                      obscureText: !_showPassword,
                      suffixIcon: IconButton(
                        onPressed: (){
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                        icon: Icon(
                          _showPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Forgot Password ?',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.accent
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: (){
                          context.pushRoute(const MainRoute());
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.background,// Splash color
                        ),
                        child: const Text(
                          'Log In',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 150),
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Don't have an account? ",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.lightText
                            ),
                          ),
                          GestureDetector(
                            onTap: () => context.pushRoute(const SignUpRoute()),
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.accent
                              ),
                            ),
                          ),
                        ],
                      ),
                    )

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