import 'package:campuscravings/src/src.dart';

@RoutePage()
class CartTabPage extends ConsumerWidget {
  const CartTabPage({super.key, this.isFromNavBar = false});
  final bool isFromNavBar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    final cartItems = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

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
                      PngAsset(
                        item.image,
                        height: size.height * .13,
                        width: size.width * .3,
                        fit: BoxFit.cover,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
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
                              price: item.price,
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
            CheckoutNavBarWidget(cartItems: cartItems),
          ],
        ),
      ),
    );
  }
}

class CartModel {
  final String image, title;
  final double price;
  int quantity;
  int tip;

  CartModel({
    required this.image,
    required this.title,
    required this.price,
    this.quantity = 1,
    this.tip = 1,
  });

  CartModel copyWith({int? quantity}) {
    return CartModel(
      image: image,
      title: title,
      price: price,
      quantity: quantity ?? this.quantity,
    );
  }
}

class CartNotifier extends StateNotifier<List<CartModel>> {
  CartNotifier()
    : super([
        CartModel(
          image: 'mock_product_1',
          title: 'Mixed Vegetable Salad',
          price: 12.00,
        ),
        CartModel(
          image: 'mock_product_1',
          title: 'Mixed Vegetable Salad',
          price: 12.00,
        ),
        CartModel(
          image: 'mock_product_1',
          title: 'Mixed Vegetable Salad',
          price: 12.00,
        ),
        CartModel(
          image: 'mock_product_1',
          title: 'Mixed Vegetable Salad',
          price: 12.00,
        ),
        CartModel(
          image: 'mock_product_1',
          title: 'Mixed Vegetable Salad',
          price: 12.00,
        ),
        CartModel(
          image: 'mock_product_1',
          title: 'Mixed Vegetable Salad',
          price: 12.00,
        ),
      ]);

  void incrementQuantity(int index) {
    final updatedItem = state[index].copyWith(
      quantity: state[index].quantity + 1,
    );
    state = [...state]..[index] = updatedItem;
  }

  void decrementQuantity(int index) {
    final currentQuantity = state[index].quantity;
    if (currentQuantity > 1) {
      final updatedItem = state[index].copyWith(quantity: currentQuantity - 1);
      state = [...state]..[index] = updatedItem;
    }
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartModel>>(
  (ref) => CartNotifier(),
);
