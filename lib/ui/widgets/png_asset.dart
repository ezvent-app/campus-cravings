import 'package:flutter/cupertino.dart';

class PngAsset extends StatelessWidget {
  final String name;
  final BoxFit? fit;
  final double? height;
  final double? width;
  final Color? color;
  final AlignmentGeometry alignment;
  const PngAsset(this.name, {super.key,
    this.fit,
    this.height,
    this.width,
    this.color,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/png/$name.png',
      fit: fit,
      height: height,
      width: width,
      color: color,
      alignment: alignment,
    );
  }
}
