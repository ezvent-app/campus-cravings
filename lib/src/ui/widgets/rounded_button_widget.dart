import 'package:campus_cravings/src/src.dart';

class RoundedButtonWidget extends StatelessWidget {
  const RoundedButtonWidget({
    super.key,
    required this.btnTitle,
    required this.onTap,
  });
  final String btnTitle;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.background, // Splash color
        ),
        child: Text(
          btnTitle,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: Dimensions.fontSizeDefault),
        ),
      ),
    );
  }
}
