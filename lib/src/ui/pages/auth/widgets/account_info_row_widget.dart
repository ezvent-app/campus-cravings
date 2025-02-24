import 'package:campus_cravings/src/src.dart';

class AccountInfoRowWidget extends StatelessWidget {
  const AccountInfoRowWidget(
      {super.key,
      required this.title,
      required this.btnTitle,
      required this.onTap});
  final String title, btnTitle;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.lightText),
          ),
          TextButton(
            onPressed: onTap,
            child: Text(
              btnTitle,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.accent),
            ),
          )
        ],
      ),
    );
  }
}
