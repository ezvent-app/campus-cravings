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

    // Filter out any null items
    final filteredCartItems = cartItems.where((item) => item != null).toList();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: isFromNavBar ? false : true,
        title: Text("Cart", style: Theme.of(context).textTheme.titleMedium),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            if (filteredCartItems.isEmpty)
              SizedBox(
                height: size.height * 0.6,
                child: Center(
                  child: Text(
                    'Your cart is empty',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              )
            else
              Column(
                children: List.generate(filteredCartItems.length, (index) {
                  final item = filteredCartItems[index];
                  return SizedBox(
                    height: size.height * .17,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Card(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CustomNetworkImage(
                                item.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 15),
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
                                      (sum, customItem) =>
                                          sum + customItem.price,
                                    ),
                                quantity: item.quantity,
                                onQuantityDecrementChanged:
                                    item.quantity <= 1
                                        ? null
                                        : () => cartNotifier.decrementQuantity(
                                          index,
                                        ),
                                onQuantityIncrementChanged:
                                    item.quantity >= 10
                                        ? null
                                        : () => cartNotifier.incrementQuantity(
                                          index,
                                        ),
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
            if (filteredCartItems.isNotEmpty)
              CheckoutNavBarWidget(cartItems: filteredCartItems),
          ],
        ),
      ),
    );
  }
}
