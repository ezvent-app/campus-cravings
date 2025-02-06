import 'package:campus_cravings/src/src.dart';

class PasswordWidget extends StatelessWidget {
  const PasswordWidget({
    super.key,
    required this.password,
    required this.passwordTitle,
  });

  final ValueNotifier<bool> password;
  final String passwordTitle;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: password,
      builder: (context, value, child) => CustomTextField(
        label: passwordTitle,
        obscureText: !value,
        suffixIcon: IconButton(
          onPressed: () => password.value = !password.value,
          icon: Icon(
            size: 18,
            value ? Icons.visibility_outlined : Icons.visibility_off_outlined,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
