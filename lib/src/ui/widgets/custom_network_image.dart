import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomNetworkImage extends StatelessWidget {
  final String url;
  final BoxFit? fit;
  final double? height;
  final double? width;
  final Color? color;
  final Alignment alignment;
  final BorderRadius borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;

  const CustomNetworkImage(
      this.url, {
        super.key,
        this.fit,
        this.height,
        this.width,
        this.color,
        this.alignment = Alignment.center,
        this.borderRadius = BorderRadius.zero,
        this.placeholder,
        this.errorWidget,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
      ),
      clipBehavior: Clip.hardEdge,
      child: CachedNetworkImage(
        imageUrl: url,
        fit: fit,
        alignment: alignment,
        placeholder: (context, url) => placeholder ?? const CupertinoActivityIndicator(),
        errorWidget: (context, url, error) => errorWidget ?? const Icon(CupertinoIcons.exclamationmark_triangle),
      ),
    );
  }
}
