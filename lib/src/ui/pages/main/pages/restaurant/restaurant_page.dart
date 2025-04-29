import 'package:cached_network_image/cached_network_image.dart';
import 'package:campuscravings/src/controllers/restaurant_details_controller.dart';
import 'package:campuscravings/src/src.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

@RoutePage()
class RestaurantPage extends ConsumerWidget {
  const RestaurantPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Get.find<RestaurantDetailsController>().getRestaurantDetails();
    final locale = AppLocalizations.of(context)!;
    final isIOS = Platform.isIOS;
    final cartItems = ref.watch(cartItemsProvider);
    return Scaffold(
      body: GetBuilder<RestaurantDetailsController>(
        builder: (controller) {
          if (controller.isLoading) {
            return _buildRestaurantDetailsShimmer(context);
          } else if (controller.isLoading == false &&
              controller.restaurantDetails == null) {
            return const Center(child: Text('Restaurant Details Not Found'));
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 30),
                width: double.infinity,
                height: 350,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      controller
                              .restaurantDetails!
                              .restaurant
                              .restaurantImages
                              .isEmpty
                          ? ''
                          : controller
                              .restaurantDetails!
                              .restaurant
                              .restaurantImages[0],
                    ),
                    fit: BoxFit.contain,
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
                        icon: Icon(
                          isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
                          color: AppColors.dividerColor,
                        ),
                      ),
                      InkWellButtonWidget(
                        onTap: () => context.pushRoute(CartTabRoute()),
                        child: CartCounterWidget(
                          count: cartItems.length,
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
                      controller.restaurantDetails!.restaurant.brandName,
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
                                '${controller.getDistanceInMiles().toStringAsFixed(2)} ${kMockFeatured.distance == 1 ? locale.mile : locale.miles} ${locale.away}',
                                style: Theme.of(context).textTheme.titleMedium!
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                            height(3),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.isRestaurantOpen()
                                      ? locale.deliveryAvailable
                                      : "Delivery Not Available",
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
          );
        },
      ),
    );
  }

  Widget _buildRestaurantDetailsShimmer(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              margin: const EdgeInsets.only(bottom: 30),
              width: double.infinity,
              height: 350,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _shimmerBox(height: 24, width: 180),
                const SizedBox(height: 24),
                const Divider(color: Colors.grey, height: 32),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _shimmerCircle(size: 24),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _shimmerBox(height: 18, width: 140),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            _shimmerBox(height: 16, width: 120),
                            const SizedBox(width: 10),
                            _shimmerBox(height: 16, width: 50),
                            const SizedBox(width: 10),
                            _shimmerCircle(size: 24),
                            const SizedBox(width: 10),
                            _shimmerBox(height: 16, width: 50),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(color: Colors.grey, height: 32),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: _shimmerBox(height: 40, width: double.infinity),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: _shimmerBox(height: 40, width: double.infinity),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _shimmerBox({required double height, required double width}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _shimmerCircle({required double size}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      ),
    );
  }
}
