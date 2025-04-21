import 'package:campuscravings/src/src.dart';

class ServiceRowWidget extends StatelessWidget {
  const ServiceRowWidget({super.key, required this.title, required this.image});

  final String title, image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Row(
        children: [
          PngAsset(image, width: 32, height: 32),
          width(20),
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.bodySmall!.copyWith(color: AppColors.black),
          ),
        ],
      ),
    );
  }
}
