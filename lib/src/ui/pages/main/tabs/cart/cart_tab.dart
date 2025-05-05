import 'package:campuscravings/src/src.dart';
import 'package:campuscravings/src/ui/widgets/custom_network_image.dart';

@RoutePage()
class CartTabPage extends ConsumerWidget {
  const CartTabPage({super.key, this.isFromNavBar = false});
  final bool isFromNavBar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    final cartItems = ref.watch(cartItemsProvider);
    final cartNotifier = ref.read(cartItemsProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: isFromNavBar ? false : true,
        title: Text("Cart", style: Theme.of(context).textTheme.titleMedium),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: List.generate(cartItems.length, (index) {
                final item = cartItems[index];
                return SizedBox(
                  height: size.height * .17,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // item.image.isEmpty
                      //     ?
                      // PngAsset(
                      //   'mock_product_1',
                      //   height: size.height * .13,
                      //   width: size.width * .3,
                      //   fit: BoxFit.cover,
                      //   borderRadius: BorderRadius.circular(16),
                      // ),
                      // : Image.network(item.image),
                      CustomNetworkImage(item.image, fit: BoxFit.fitWidth),
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.black,
                              ),
                            ),
                            height(10),
                            QuantitySelectorWidget(
                              price:
                                  item.price +
                                  item.sizePrice +
                                  item.customization.fold(
                                    0.0,
                                    (sum, customItem) => sum + customItem.price,
                                  ),

                              quantity: item.quantity,
                              onQuantityDecrementChanged:
                                  item.quantity <= 1
                                      ? null
                                      : () =>
                                          cartNotifier.decrementQuantity(index),
                              onQuantityIncrementChanged:
                                  item.quantity >= 10
                                      ? null
                                      : () =>
                                          cartNotifier.incrementQuantity(index),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
            height(40),
            // aCheckoutNavBarWidget(cartItems: cartItems),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: CheckoutNavBarWidget(cartItems: cartItems),
      ),
    );
  }
}
