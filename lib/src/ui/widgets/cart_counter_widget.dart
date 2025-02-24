import 'package:campuscravings/src/src.dart';

class CartCounterWidget extends StatelessWidget {
  const CartCounterWidget({
    super.key,
    this.color = AppColors.unselectedTabIconColor,
    required this.count,
  });
  final Color color;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Badge.count(
      count: count,
      textColor: AppColors.dividerColor,
      backgroundColor: AppColors.accent,
      child: SvgAssets(Images.cart, color: color),
    );
  }
}
