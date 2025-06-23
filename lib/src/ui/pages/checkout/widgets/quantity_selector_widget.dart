import 'package:campuscravings/src/src.dart';

class QuantitySelectorWidget extends ConsumerWidget {
  const QuantitySelectorWidget({
    super.key,
    required this.price,
    required this.quantity,
    required this.onQuantityIncrementChanged,
    required this.onQuantityDecrementChanged,
  });

  final double price;
  final int quantity;
  final VoidCallback? onQuantityIncrementChanged;
  final VoidCallback? onQuantityDecrementChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const int max = 10;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '\$${(price * quantity).toStringAsFixed(2)}',
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        width(10),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFFF6F6F6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWellButtonWidget(
                    onTap: onQuantityDecrementChanged,
                    borderRadius: BorderRadius.circular(12),
                    child: Icon(
                      Icons.remove,
                      size: 20,
                      color: quantity <= 1 ? Colors.black : Colors.black,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  quantity.toString(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWellButtonWidget(
                    onTap: quantity >= max ? null : onQuantityIncrementChanged,
                    borderRadius: BorderRadius.circular(12),
                    child: Icon(
                      Icons.add,
                      size: 20,
                      color: quantity >= max ? Colors.grey : Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
