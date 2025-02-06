import 'package:campus_cravings/src/src.dart';

@RoutePage()
class ChangePasswordPage extends ConsumerStatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  ConsumerState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends ConsumerState<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    return const BaseWrapper(
      label: 'Change Password',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            label: 'Enter Old Password',
            obscureText: true,
          ),
          SizedBox(height: 16),
          CustomTextField(
            label: 'Enter New Password',
            obscureText: true,
          ),
          SizedBox(height: 16),
          CustomTextField(
            label: 'Confirm New Password',
            obscureText: true,
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
