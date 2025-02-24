import 'package:campuscravings/src/src.dart';

class AchievmentsRowWidget extends StatelessWidget {
  const AchievmentsRowWidget({
    super.key,
    required this.image,
    required this.title,
    required this.value,
  });
  final String image, title, value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PngAsset(image, width: 40, height: 40),
        width(10),
        Column(
          children: [
            Text(
              value,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(color: AppColors.lightText),
            ),
          ],
        ),
      ],
    );
  }
}
