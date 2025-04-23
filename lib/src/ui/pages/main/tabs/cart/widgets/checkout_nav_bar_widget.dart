import 'package:campuscravings/src/src.dart';

class CheckoutNavBarWidget extends StatelessWidget {
  const CheckoutNavBarWidget({super.key, required this.cartItems});

  final List cartItems;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Sub Total", style: Theme.of(context).textTheme.bodyLarge),
            Text(
              "\$${cartItems.map((item) => item.price * item.quantity).fold(0.0, (a, b) => a + b).toStringAsFixed(2)}",
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
