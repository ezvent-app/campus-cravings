import 'package:campuscravings/src/src.dart';

class CheckoutNavBarWidget extends ConsumerWidget {
  const CheckoutNavBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartItemsProvider);

    final subtotal = cartItems
        .map(
          (item) =>
              (item.price +
                  item.sizePrice +
                  item.customization.fold(0.0, (sum, c) => sum + c.price)) *
              item.quantity,
        )
        .fold(0.0, (a, b) => a + b);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Sub Total", style: Theme.of(context).textTheme.bodyLarge),
            Text(
              "\$${subtotal.toStringAsFixed(2)}",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        width(10),
        ActionChip(
          tooltip: "Check Out",
          backgroundColor: AppColors.black,
          label: Row(
            children: [
              Text(
                "Check out",
                style: Theme.of(
                  context,
                ).textTheme.titleSmall!.copyWith(color: AppColors.white),
              ),
              width(5),
              SizedBox(
                width: 40,
                height: 40,
                child: Card(
                  color: AppColors.accent,
                  shape: const StadiumBorder(),
                  child: Center(
                    child: Text(
                      cartItems.length.toString(),
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          onPressed: () => context.pushRoute(CheckOutTabRoute()),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ],
    );
  }
}
