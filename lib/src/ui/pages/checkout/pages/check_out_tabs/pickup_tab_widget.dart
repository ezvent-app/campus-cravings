import 'package:campuscravings/src/src.dart';

class PickUpTabWidget extends StatelessWidget {
  const PickUpTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 25),
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
                  children: List.generate(4, (index) {
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
                                'mock_product_1',
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
                                        'Mixed Vegetable Salad',
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '\$12.00',
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(
                                              context,
                                            ).textTheme.titleSmall,
                                          ),
                                          width(10),
                                          QuantitySelectorWidget(),
                                        ],
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
                context.pushRoute(const CheckoutAddressRoute());
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.background, // Splash color
              ),
              child: Text(
                '${locale.placeOrder} - \$24.00',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
