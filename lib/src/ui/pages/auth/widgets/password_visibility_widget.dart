import 'package:campus_cravings/src/src.dart';

class PasswordWidget extends StatelessWidget {
  const PasswordWidget({
    super.key,
    required this.password,
    required this.passwordTitle,
    this.onChanged,
    this.textInputType,
    this.textInputAction,
  });

  final ValueNotifier<bool> password;
  final String passwordTitle;
  final ValueChanged<String>? onChanged;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: password,
      builder:
          (context, value, child) => CustomTextField(
            onChanged: onChanged,
            label: passwordTitle,
            obscureText: !value,
            textInputAction: textInputAction,
            textInputType: textInputType ?? TextInputType.visiblePassword,
            suffixIcon: IconButton(
              onPressed: () => password.value = !password.value,
              icon: Icon(
                size: 18,
                value
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: Colors.grey,
              ),
            ),
          ),
    );
  }
}
