import 'package:campuscravings/src/src.dart';
import 'package:campuscravings/src/ui/widgets/custom_network_image.dart';
import 'package:logger/logger.dart';

class PickupTabWidget extends ConsumerWidget {
  PickupTabWidget({super.key});

  final PlaceOrderRepository _repository = PlaceOrderRepository();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = AppLocalizations.of(context)!;
    final cartItems = ref.watch(cartItemsProvider);
    final cartNotifier = ref.read(cartItemsProvider.notifier);
    final subtotal = cartItems
        .map((item) => item.price * item.quantity)
        .fold(0.0, (a, b) => a + b);

    final tip = ref.watch(selectedTipProvider);

    double platformTenPercent = subtotal * 0.10;

    String platformFee = '\$${platformTenPercent.toStringAsFixed(2)}';

    final total = subtotal + tip + platformTenPercent;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 15, top: 4),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.name,
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
          // Container(
          //   margin: const EdgeInsets.only(bottom: 24),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(24),
          //     color: Colors.white,
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.black.withValues(alpha: .08),
          //         blurRadius: 15,
          //       ),
          //     ],
          //   ),
          //   child: Material(
          //     color: Colors.transparent,
          //     child: InkWellButtonWidget(
          //       onTap: () {
          //         context.pushRoute(PaymentMethodsRoute(fromCheckout: true));
          //       },
          //       borderRadius: BorderRadius.circular(24),
          //       child: Padding(
          //         padding: EdgeInsets.all(24),
          //         child: Row(
          //           children: [
          //             SvgAssets('redWallet', height: 24, width: 24),
          //             Expanded(
          //               flex: 2,
          //               child: Padding(
          //                 padding: EdgeInsets.symmetric(horizontal: 12),
          //                 child: Text(
          //                   locale.paymentMethod,
          //                   maxLines: 2,
          //                   overflow: TextOverflow.ellipsis,
          //                   style: TextStyle(
          //                     color: Color(0xff212121),
          //                     fontSize: 14,
          //                     fontWeight: FontWeight.w500,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //             Expanded(
          //               flex: 2,
          //               child: Padding(
          //                 padding: EdgeInsets.only(right: 12),
          //                 child: Text(
          //                   'Villanova Vallet',
          //                   textAlign: TextAlign.end,
          //                   maxLines: 2,
          //                   overflow: TextOverflow.ellipsis,
          //                   style: Theme.of(
          //                     context,
          //                   ).textTheme.bodyMedium!.copyWith(
          //                     color: AppColors.black,
          //                     fontWeight: FontWeight.w600,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //             Icon(
          //               Icons.keyboard_arrow_right,
          //               color: AppColors.accent,
          //               size: 30,
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
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
                      "Platform Fee",
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
                          platformFee,
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

                Row(
                  children: [
                    Text(
                      "Tip",
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
                          "\$${tip.toString()}",
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
                          "\$${total.toStringAsFixed(2)}",
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
          PickUpPlaceOrderButtonWidget(
            total: total,
            repository: _repository,
            orderType: "delivery",
            cartItems: cartItems,
            tip: tip,
            locale: locale,
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

class PickUpPlaceOrderButtonWidget extends ConsumerWidget {
  const PickUpPlaceOrderButtonWidget({
    super.key,
    required this.cartItems,
    required this.total,
    required this.tip,
    required this.locale,
    required this.orderType,
    required this.repository,
  });

  final List<CartItem> cartItems;
  final int tip;
  final AppLocalizations locale;
  final String orderType;
  final PlaceOrderRepository repository;
  final double total;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final address = ref.watch(locationProvider);

    return Container(
      width: double.infinity,
      height: 48,
      margin: const EdgeInsets.only(bottom: 36),
      child: ElevatedButton(
        onPressed: () async {
          Logger().w("680fa7939425b7cd2b7d3201");
          //Logger().w("${Get.find<LocationController>().locationData?.latitude} - ${Get.find<LocationController>().locationData?.longitude}");
          context.pushRoute(DeliveringRoute());
          // List<Map<String, dynamic>> orderItemsJson =
          //     cartItems.map((item) => item.toOrderItemJson()).toList();
          // final json = {
          //   "payment_method": "card",
          //   "tip": tip,
          //   "delivery_fee": total,
          //   "order_type": orderType,
          //   "addresses": address.value?.addresses ?? "",
          //   "items": orderItemsJson,
          // };
          // log("CHECKOUT JSON $json");
          // // repository.placeOrderMethod(json, context);
          // // context.pushRoute(const CheckoutAddressRoute());
          //
          // await repository.makePayment(
          //   context: context,
          //   purchaseName: "Ali",
          //   title: "Garden Service",
          //   amountPaid: total.toDouble(),
          //   merchantDisplayName: "Default Merchant",
          //   onSuccess: (transactionId) async {
          //     log("Payment Successful with Transaction ID: $transactionId");
          //     repository.placeOrderMethod(json, context);
          //     cartItems.clear();
          //   },
          // );
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.background,
        ),
        child: Text(
          '${locale.placeOrder} - \$${total.toStringAsFixed(2)}',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
