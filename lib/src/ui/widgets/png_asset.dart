import 'package:flutter/cupertino.dart';

class PngAsset extends StatelessWidget {
  final String name;
  final BoxFit? fit;
  final double? height;
  final double? width;
  final Color? color;
  final AlignmentGeometry alignment;
  final BorderRadius borderRadius;
  const PngAsset(
    this.name, {
    super.key,
    this.fit,
    this.height,
    this.width,
    this.color,
    this.alignment = Alignment.center,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius,
          image: DecorationImage(
            image: AssetImage('assets/images/png/$name.png'),
            fit: fit,
            alignment: alignment,
          )),
    );
  }
}
