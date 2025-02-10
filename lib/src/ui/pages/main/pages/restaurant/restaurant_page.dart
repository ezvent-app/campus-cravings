import 'package:campus_cravings/src/src.dart';

@RoutePage()
class RestaurantPage extends ConsumerStatefulWidget {
  const RestaurantPage({super.key});

  @override
  ConsumerState createState() => _RestaurantPageState();
}

class _RestaurantPageState extends ConsumerState<RestaurantPage> {
  @override
  Widget build(BuildContext context) {
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
                      fit: BoxFit.fitWidth)),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back,
                          color: AppColors.dividerColor,
                        )),
                    CartCounterWidget(
                      count: 5,
                      color: AppColors.dividerColor,
                    )
                  ],
                ),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Bamonte's",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                const Divider(color: AppColors.dividerColor, height: 32),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (kMockFeatured.distance != null)
                      const Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: PngAsset(
                          'location_pin',
                          width: 24,
                          height: 24,
                        ),
                      ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (kMockFeatured.distance != null)
                          Text(
                            '${kMockFeatured.distance!.floor()} ${kMockFeatured.distance == 1 ? 'mile' : 'miles'} away',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        const SizedBox(height: 3),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Delivery Available',
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
                            const PngAsset(
                              'travel_icon',
                              width: 25,
                              height: 20,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '\$${kMockFeatured.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppColors.lightText,
                                fontWeight: FontWeight.w500,
                              ),
                            )
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
