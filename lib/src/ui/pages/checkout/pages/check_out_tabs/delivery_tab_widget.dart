import 'package:campus_cravings/src/src.dart';

class DeliveryTabWidget extends StatelessWidget {
  const DeliveryTabWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 25),
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
                  )
                ]),
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
                        'Deliver to',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 20),
                      Divider(height: 0, color: AppColors.dividerColor),
                    ],
                  ),
                ),
                HomeLocationWidget(
                  title: "Home",
                  subTitle: '5259 Blue Bill Park, PC 4627',
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(
              vertical: 16,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.08),
                  blurRadius: 15,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order Summary',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Column(
                  children: List.generate(
                    4,
                    (index) {
                      return Column(
                        children: [
                          const Divider(
                              color: AppColors.dividerColor, height: 40),
                          SizedBox(
                            height: 95,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PngAsset('mock_product_1',
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.cover,
                                    borderRadius: BorderRadius.circular(16)),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 4),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Mixed Vegetable Salad',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall),
                                        Spacer(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '\$12.00',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Color(0xff4C4C4C),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            index == 0
                                                ? QuantitySelectorWidget()
                                                : SizedBox()
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                index == 0
                                    ? SizedBox()
                                    : Container(
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: AppColors.black),
                                        ),
                                        child: Center(
                                          child: Text('1x',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                      color: AppColors.black)),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
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
                BoxShadow(color: Colors.black.withOpacity(.08), blurRadius: 15)
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  context.pushRoute(PaymentMethodsRoute(fromCheckout: true));
                },
                borderRadius: BorderRadius.circular(24),
                child: const Padding(
                  padding: EdgeInsets.all(24),
                  child: Row(
                    children: [
                      PngAsset(
                        'payment_method2_icon',
                        height: 24,
                        width: 24,
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'Payment\nMethod',
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
                            style: TextStyle(
                              color: Color(0xff212121),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
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
                BoxShadow(color: Colors.black.withOpacity(.08), blurRadius: 15)
              ],
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Subtotal',
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
                          '\$24.00',
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
                      'Delivery Fee',
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
                          '\$2.00',
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
                Text(
                  '+ Add Tip',
                  style: TextStyle(
                    color: AppColors.accent,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Divider(
                  height: 40,
                  color: AppColors.dividerColor,
                ),
                Row(
                  children: [
                    Text(
                      'Total',
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
                          '\$26.00',
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
          const Divider(
            height: 48,
            color: AppColors.dividerColor,
          ),
          Container(
            width: double.infinity,
            height: 48,
            margin: const EdgeInsets.only(bottom: 36),
            child: ElevatedButton(
              onPressed: () {
                context.pushRoute(const CheckoutAddressRoute());
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.background, // Splash color
              ),
              child: const Text(
                'Place Order - \$26.00',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
