import 'dart:developer';

import 'package:campuscravings/src/src.dart';
import 'package:campuscravings/src/ui/widgets/custom_network_image.dart';
import 'package:geolocator/geolocator.dart';

class DeliveryTabWidget extends ConsumerWidget {
  DeliveryTabWidget({super.key});

  final PlaceOrderRepository _repository = PlaceOrderRepository();

  Future<double> calculateDeliveryFee({required double distanceInMiles}) async {
    const double baseFee = 0.50;
    const double perMileFee = 0.70;

    final double demandMultiplier =
        await _repository.fetchDemandMultiplierOnly();

    log(demandMultiplier.toString());

    double milesBeyondFirst = (distanceInMiles > 1) ? (distanceInMiles - 1) : 0;

    double totalFee =
        baseFee + (perMileFee * milesBeyondFirst * demandMultiplier);

    final feeRounded = double.parse(totalFee.toStringAsFixed(2));
    log("Delivery fee: \$$feeRounded");

    return feeRounded;
  }

  double _calculateDistanceInMiles(LatLng from, LatLng to) {
    double distanceInMeters = Geolocator.distanceBetween(
      from.latitude,
      from.longitude,
      to.latitude,
      to.longitude,
    );

    log("DISTANCE ${(distanceInMeters / 1609.34).toStringAsFixed(2)}");
    return distanceInMeters / 1609.34;
  }

  LatLng? getLatLngFromOrderAddress(OrderAddress? orderAddress) {
    final coords = orderAddress?.coordinates?.coordinates;
    if (coords != null && coords.length == 2) {
      final double lat = coords[1]; // latitude
      final double lng = coords[0]; // longitude
      return LatLng(lat, lng);
    }
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = AppLocalizations.of(context)!;
    final cartItems = ref.watch(cartItemsProvider);
    final cartNotifier = ref.read(cartItemsProvider.notifier);
    final address = ref.watch(locationProvider);
    final subtotal = cartItems
        .map((item) => item.price * item.quantity)
        .fold(0.0, (a, b) => a + b);

    final tip = ref.watch(selectedTipProvider);

    double platformTenPercent = subtotal * 0.10;

    String platformFee = '\$${platformTenPercent.toStringAsFixed(2)}';

    final locationAsync = ref.watch(locationProvider);
    final total = subtotal + tip + platformTenPercent;

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
                HomeLocationWidget(title: locale.home, subTitle: ''),
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
                              CustomNetworkImage(
                                item.image,
                                fit: BoxFit.fitWidth,
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

                locationAsync.when(
                  data: (locationModel) {
                    final LatLng? customerLatLng = getLatLngFromOrderAddress(
                      address.value?.addresses,
                    );

                    if (customerLatLng == null) {
                      return Text("Customer location is missing");
                    }

                    final distance = _calculateDistanceInMiles(
                      customerLatLng,
                      LatLng(
                        cartItems.first.restCoordinates[0],
                        cartItems.first.restCoordinates[1],
                      ),
                    );

                    log(
                      "CUSTOMER ${customerLatLng.toString()} RESTUARANT ${cartItems.first.restCoordinates}",
                    );

                    return FutureBuilder(
                      future: calculateDeliveryFee(distanceInMiles: distance),

                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SizedBox();
                        }

                        // If error occurs
                        if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        }
                        final deliveryFee = snapshot.data!;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                      "\$${deliveryFee.toStringAsFixed(2)}",
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
                              onPressed:
                                  () async =>
                                      await orderTipSheetMethod(context),
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
                                      "\$${(total + deliveryFee).toStringAsFixed(2)}",
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
                            const Divider(
                              height: 48,
                              color: AppColors.dividerColor,
                            ),
                            CheckPlaceOrderButtonWidget(
                              deliveryFee: deliveryFee,
                              total: total + deliveryFee,
                              repository: _repository,
                              orderType: "delivery",
                              cartItems: cartItems,
                              tip: tip,
                              locale: locale,
                            ),
                          ],
                        );
                      },
                    );
                  },
                  loading: () => CircularProgressIndicator(),
                  error: (err, stack) => SizedBox(),
                ),
              ],
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

class CheckPlaceOrderButtonWidget extends ConsumerWidget {
  const CheckPlaceOrderButtonWidget({
    super.key,
    required this.cartItems,
    required this.total,
    required this.tip,
    required this.locale,
    required this.orderType,
    required this.repository,
    required this.deliveryFee,
  });

  final List<CartItem> cartItems;
  final int tip;
  final AppLocalizations locale;
  final String orderType;
  final PlaceOrderRepository repository;
  final double total;
  final double deliveryFee;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final address = ref.watch(locationProvider);
    final locationAsync = ref.watch(locationProvider);
    return Container(
      width: double.infinity,
      height: 48,
      margin: const EdgeInsets.only(bottom: 36),
      child: ElevatedButton(
        onPressed: () async {
          List<Map<String, dynamic>> orderItemsJson =
              cartItems.map((item) => item.toOrderItemJson()).toList();

          // repository.placeOrderMethod(json, context);
          // context.pushRoute(const CheckoutAddressRoute());

          final LatLng? restuatantLatLng = getLatLngFromOrderAddress(
            address.value?.addresses,
          );

          locationAsync.whenData((locationModel) async {
            if (restuatantLatLng != null) {
              final distance = _calculateDistanceInMiles(
                locationModel.latLng,
                restuatantLatLng,
              );

              log(
                "...............................................................",
              );
              log("CUSTOMER ${locationModel.latLng}");
              log("RESTAUNARANT $restuatantLatLng");
              log("DISTANCE IN MILES ${distance.toStringAsFixed(2)}");
              log('Total Delivery Fee: \$$deliveryFee');
              log(
                "...............................................................",
              );

              final json = {
                "payment_method": "card",
                "tip": tip,
                "delivery_fee": deliveryFee,
                "order_type": orderType,
                "addresses": address.value?.addresses ?? "",
                "items": orderItemsJson,
              };
              log("CHECKOUT JSON $json");
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

              repository.placeOrderMethod(json, context);
            } else {
              log("Customer location is not available.");
            }
          });
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

  double calculateDeliveryFee({
    required double distanceInMiles,
    required int ordersInCampus,
    required int ridersInCampus,
  }) {
    const double baseFee = 0.50;
    const double perMileFee = 0.70;

    double demandMultiplier =
        ridersInCampus > 0 ? ordersInCampus / ridersInCampus : 1;

    double milesBeyondFirst = (distanceInMiles > 1) ? (distanceInMiles - 1) : 0;

    double totalFee =
        baseFee + (perMileFee * milesBeyondFirst * demandMultiplier);

    return double.parse(totalFee.toStringAsFixed(2));
  }

  double _calculateDistanceInMiles(LatLng from, LatLng to) {
    double distanceInMeters = Geolocator.distanceBetween(
      from.latitude,
      from.longitude,
      to.latitude,
      to.longitude,
    );

    return distanceInMeters / 1609.34;
  }

  LatLng? getLatLngFromOrderAddress(OrderAddress? orderAddress) {
    final coords = orderAddress?.coordinates?.coordinates;
    if (coords != null && coords.length == 2) {
      final double lat = coords[1]; // latitude
      final double lng = coords[0]; // longitude
      return LatLng(lat, lng);
    }
    return null;
  }
}

final tipsProvider = StateProvider((ref) => 0);
final selectedTipProvider = StateProvider((ref) => 0);
