import 'package:campuscravings/src/src.dart';

class InkWellButtonWidget extends StatelessWidget {
  const InkWellButtonWidget(
      {super.key, required this.child, required this.onTap, this.borderRadius});
  final Widget child;
  final Function()? onTap;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      borderRadius: borderRadius,
      onTap: onTap,
      child: child,
    );
  }
}
