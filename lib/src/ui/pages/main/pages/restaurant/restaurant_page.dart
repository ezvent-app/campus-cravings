import 'package:campuscravings/src/src.dart';

@RoutePage()
class RestaurantPage extends ConsumerWidget {
  const RestaurantPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            width: double.infinity,
            height: 350,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/png/mock_product_1.png"),
                fit: BoxFit.fitWidth,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 20, top: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back, color: AppColors.dividerColor),
                  ),
                  InkWellButtonWidget(
                    onTap: () => context.pushRoute(CheckOutTabRoute()),
                    child: CartCounterWidget(
                      count: 2,
                      color: AppColors.dividerColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Bamonte's",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Divider(color: AppColors.dividerColor, height: 32),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (kMockFeatured.distance != null)
                      const Padding(
                        padding: EdgeInsets.only(right: 10, top: 3),
                        child: SvgAssets('redLoc', width: 24, height: 24),
                      ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (kMockFeatured.distance != null)
                          Text(
                            '${kMockFeatured.distance!.floor()} ${kMockFeatured.distance == 1 ? locale.mile : locale.miles} ${locale.away}',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        height(3),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              locale.deliveryAvailable,
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.lightText,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              width: 2,
                              height: 20,
                              color: AppColors.lightText,
                            ),
                            const SvgAssets('bike', width: 24, height: 24),
                            const SizedBox(width: 10),
                            Text(
                              '\$${kMockFeatured.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppColors.lightText,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(color: AppColors.dividerColor, height: 32),
              ],
            ),
          ),
          const CategoryTabs(products: mockProducts),
        ],
      ),
    );
  }
}
