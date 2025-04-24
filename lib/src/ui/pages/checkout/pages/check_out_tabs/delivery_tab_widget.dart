import 'package:campuscravings/src/src.dart';
import 'package:campuscravings/src/ui/pages/main/tabs/cart/cart_tab.dart';

class DeliveryTabWidget extends ConsumerWidget {
  DeliveryTabWidget({super.key});

  final PlaceOrderRepository _repository = PlaceOrderRepository();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = AppLocalizations.of(context)!;
    final cartItems = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);
    final subtotal = cartItems
        .map((item) => item.price * item.quantity)
        .fold(0.0, (a, b) => a + b);

    final tip = ref.watch(selectedTipProvider);
    final total = subtotal + tip;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .08),
                  blurRadius: 15,
                ),
              ],
            ),
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        locale.deliverTo,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 20),
                      Divider(height: 0, color: AppColors.dividerColor),
                    ],
                  ),
                ),
                HomeLocationWidget(
                  title: locale.home,
                  subTitle: '5259 Blue Bill Park, PC 4627',
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .08),
                  blurRadius: 15,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  locale.orderSummary,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Column(
                  children: List.generate(cartItems.length, (index) {
                    final item = cartItems[index];
                    return Column(
                      children: [
                        const Divider(
                          color: AppColors.dividerColor,
                          height: 40,
                        ),
                        SizedBox(
                          height: 100,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PngAsset(
                                item.image,
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 15, top: 4),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.title,
                                        maxLines: 2,
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
                                        onQuantityDecrementChanged:
                                            item.quantity <= 1
                                                ? null
                                                : () => cartNotifier
                                                    .decrementQuantity(index),
                                        onQuantityIncrementChanged:
                                            item.quantity >= 10
                                                ? null
                                                : () => cartNotifier
                                                    .incrementQuantity(index),
                                        price: item.price,
                                        quantity: item.quantity,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .08),
                  blurRadius: 15,
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWellButtonWidget(
                onTap: () {
                  context.pushRoute(PaymentMethodsRoute(fromCheckout: true));
                },
                borderRadius: BorderRadius.circular(24),
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Row(
                    children: [
                      SvgAssets('redWallet', height: 24, width: 24),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            locale.paymentMethod,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Color(0xff212121),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: Text(
                            'Villanova Vallet',
                            textAlign: TextAlign.end,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: AppColors.accent,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .08),
                  blurRadius: 15,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      locale.subTotal,
                      style: TextStyle(
                        color: Color(0xff424242),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text(
                          "\$${cartItems.map((item) => item.price * item.quantity).fold(0.0, (a, b) => a + b).toStringAsFixed(2)}",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Color(0xff424242),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      locale.deliveryFee,
                      style: TextStyle(
                        color: Color(0xff424242),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text(
                          '\$ $tip',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Color(0xff424242),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () async => await orderTipSheetMethod(context),
                  child: Text(
                    '+ ${locale.addTip}',
                    style: TextStyle(
                      color: AppColors.accent,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Divider(height: 40, color: AppColors.dividerColor),
                Row(
                  children: [
                    Text(
                      locale.total,
                      style: TextStyle(
                        color: Color(0xff424242),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text(
                          "\$$total",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Color(0xff424242),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 48, color: AppColors.dividerColor),
          Container(
            width: double.infinity,
            height: 48,
            margin: const EdgeInsets.only(bottom: 36),
            child: ElevatedButton(
              onPressed: () {
                final json = {
                  "payment_method": "cash",
                  "tip": 3,
                  "delivery_fee": 2,
                  "addresses": {
                    "address": "123 Main St",
                    "coordinates": {
                      "type": "Point",
                      "coordinates": [73.1234, 33.5678],
                    },
                  },
                  "items": [
                    {
                      "item_id": "68062020b63dae4410847f75",
                      "quantity": 2,
                      "customizations": [
                        "68062020b63dae4410847f76",
                        "68062020b63dae4410847f77",
                      ],
                    },
                    {
                      "item_id": "68062026b63dae4410847f82",
                      "quantity": 5,
                      "customizations": [
                        "68062026b63dae4410847f85", // Customization Id
                      ],
                    },
                  ],
                };
                _repository.placeOrderMethod(json, context);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.background,
              ),
              child: Text(
                '${locale.placeOrder} - \$26.00',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> orderTipSheetMethod(BuildContext context) {
    List tipsList = [1, 5, 10, 15];
    final locale = AppLocalizations.of(context)!;

    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Card(
          margin: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          locale.addTip,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.clear, color: AppColors.email),
                    ),
                  ],
                ),
                height(20),
                Text(
                  "${locale.wantToLeaveTipFor} Robert",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: AppColors.lightText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Consumer(
                  builder: (context, ref, _) {
                    var selectedIndex = ref.watch(tipsProvider);
                    return Wrap(
                      children: List.generate(
                        tipsList.length,
                        (i) => InkWellButtonWidget(
                          borderRadius: BorderRadius.circular(15),
                          onTap: () {
                            ref.read(tipsProvider.notifier).state = i;
                            ref.read(selectedTipProvider.notifier).state =
                                tipsList[i];
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              width: 140,
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color:
                                      selectedIndex == i
                                          ? AppColors.black
                                          : Colors.grey,
                                ),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    "\$${tipsList[i]}",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge!.copyWith(
                                      color:
                                          selectedIndex == i
                                              ? AppColors.black
                                              : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                height(20),
                Consumer(
                  builder: (context, ref, child) {
                    return CustomTextField(
                      label: 'Enter tip',
                      hintText: '\$2',
                      textInputType: TextInputType.number,
                      onSubmitted:
                          (value) =>
                              ref.read(selectedTipProvider.notifier).state =
                                  int.tryParse(value)!,
                    );
                  },
                ),
                height(30),
                RoundedButtonWidget(
                  btnTitle: locale.confirm,
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

final tipsProvider = StateProvider((ref) => 0);
final selectedTipProvider = StateProvider((ref) => 0);
