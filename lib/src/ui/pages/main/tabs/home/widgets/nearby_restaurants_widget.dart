import 'package:campuscravings/src/constants/get_builder_id_constants.dart';
import 'package:campuscravings/src/controllers/food_and_restaurant_search_controller.dart';
import 'package:campuscravings/src/controllers/restaurant_details_controller.dart';
import 'package:campuscravings/src/controllers/resturant_controller.dart';
import 'package:campuscravings/src/src.dart';
import 'package:campuscravings/src/ui/widgets/custom_network_image.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class NearbyRestaurantsWidget extends ConsumerStatefulWidget {
  const NearbyRestaurantsWidget({super.key});

  @override
  ConsumerState createState() => _NearbyRestaurantsWidgetState();
}

class _NearbyRestaurantsWidgetState
    extends ConsumerState<NearbyRestaurantsWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FoodAndRestaurantSearchController>(
      builder: (searchController) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 25, top: 10),
              child: Text(
                'Restaurants Nearby',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            GetBuilder<RestaurantController>(
              id: nearByRestaurantBuilderId,
              initState: (state) {
                Get.find<RestaurantController>().getNearByRestaurants();
              },
              builder: (controller) {
                if (controller.isLoading) {
                  return _buildRestaurantShimmer();
                } else if (controller.isLoading == false &&
                    controller.listOfNearByRestaurants.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text('No nearby restaurants found'),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: controller.getFilteredRestaurants().length,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final restaurant = controller
                        .getFilteredRestaurants()[index];
                    return InkWellButtonWidget(
                      onTap: () {
                        Get.find<RestaurantDetailsController>().setRestaurantId(
                          restaurant.id,
                        );
                        context.pushRoute(const RestaurantRoute());
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 25,
                        ),
                        child: Row(
                          children: [
                            CustomNetworkImage(
                              restaurant.restaurantImages.isEmpty
                                  ? ''
                                  : restaurant.restaurantImages[0],
                              borderRadius: BorderRadius.circular(200),
                              fit: BoxFit.cover,
                              width: 110,
                              height: 110,
                            ),
                            const SizedBox(width: 25),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    restaurant.storeName,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0xff443A39),
                                    ),
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    restaurant.cuisine,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xffB4B0B0),
                                    ),
                                  ),
                                  SizedBox(height: 7),
                                  Text(
                                    '${controller.getRestaurantTimingForToday(restaurant: restaurant)} | ${controller.getDistanceInMiles(lat: restaurant.address.coordinates.coordinates[1], lng: restaurant.address.coordinates.coordinates[0]).toStringAsFixed(2)} mil away',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff443A39),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildRestaurantShimmer() {
    return Column(
      children: List.generate(10, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Row(
            children: [
              Shimmer.fromColors(
                baseColor: const Color(0xffE0E0E0),
                highlightColor: const Color(0xffF5F5F5),
                child: Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(200),
                  ),
                ),
              ),
              const SizedBox(width: 25),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: const Color(0xffE0E0E0),
                      highlightColor: const Color(0xffF5F5F5),
                      child: Container(
                        width: 150,
                        height: 18,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Shimmer.fromColors(
                      baseColor: const Color(0xffE0E0E0),
                      highlightColor: const Color(0xffF5F5F5),
                      child: Container(
                        width: 100,
                        height: 14,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Shimmer.fromColors(
                      baseColor: const Color(0xffE0E0E0),
                      highlightColor: const Color(0xffF5F5F5),
                      child: Container(
                        width: 120,
                        height: 12,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
