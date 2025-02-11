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
        child: Text(
          btnTitle,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
