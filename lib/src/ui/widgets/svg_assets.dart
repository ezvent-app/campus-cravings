import 'package:campuscravings/src/src.dart';

class SvgAssets extends StatelessWidget {
  const SvgAssets(this.name, {super.key, this.height, this.width, this.color});
  final String name;
  final double? height;
  final double? width;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/images/svg/$name.svg",
      color: color,
      width: width,
      height: height,
    );
  }
}
