import 'package:campuscravings/src/controllers/food_and_restaurant_search_controller.dart';
import 'package:campuscravings/src/controllers/restaurant_details_controller.dart';
import 'package:campuscravings/src/models/User%20Model/nearby_restaurants_model.dart';
import 'package:campuscravings/src/models/restaurant_details_model.dart';
import 'package:campuscravings/src/src.dart';
import 'package:campuscravings/src/ui/widgets/custom_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CategoryDisplayingPage extends StatefulWidget {
  final String category;
  const CategoryDisplayingPage({super.key, required this.category});

  @override
  State<CategoryDisplayingPage> createState() => _CategoryDisplayingPageState();
}

class _CategoryDisplayingPageState extends State<CategoryDisplayingPage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Get.find<FoodAndRestaurantSearchController>().getSearchCategory(
        context,
        widget.category,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        titleSpacing: 0,
        title: Text(widget.category),
      ),

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: GetBuilder<FoodAndRestaurantSearchController>(
                builder: (controller) {
                  if (controller.isOperationInProgress) {
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      itemCount: 4,
                      itemBuilder: (_, __) => _searchItemShimmer(),
                    );
                  }
                  if (controller.listOfFoodItemModel.isEmpty) {
                    return Center(
                      child: Text(
                        'No items available under the "${widget.category}" category at the moment.',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 10,
                    ),
                    itemCount: controller.listOfFoodItemModel.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = controller.listOfFoodItemModel[index];
                      return InkWell(
                        onTap: () {
                          Get.find<RestaurantDetailsController>()
                              .setRestaurantId(item.restaurant);
                          context.pushRoute(
                            RestaurantRoute(initialItemId: item.id),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.09),
                                blurRadius: 15,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              CustomNetworkImage(
                                item.image.first,
                                width: 90,
                                height: 90,
                                fit: BoxFit.cover,
                              ),
                              width(15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    height(4),
                                    Row(
                                      children: [
                                        SvgAssets(
                                          'linear_clock',
                                          width: 10,
                                          height: 10,
                                        ),
                                        width(4),
                                        Text(
                                          '${item.estimatedPreparationTime} min',
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                    height(4),
                                    Text(
                                      _getItemPrice(item),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchItemShimmer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15),
        ],
      ),
      child: Row(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          width(15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _shimmerBox(width: 120, height: 15),
                height(8),
                Row(
                  children: [
                    _shimmerBox(width: 60, height: 10),
                    width(5),
                    _shimmerBox(width: 30, height: 10),
                  ],
                ),
                height(8),
                _shimmerBox(width: 50, height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _shimmerBox({double width = double.infinity, double height = 10}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }

  String _getItemPrice(FoodItem item) {
    if (item.price == 0) {
      final sizePrices = item.sizes.map((s) => s.price);
      if (sizePrices.isNotEmpty) {
        final minSizePrice = sizePrices.reduce((a, b) => a < b ? a : b);
        return '\$${minSizePrice.toStringAsFixed(2)}';
      }
    }
    return '\$${item.price.toStringAsFixed(2)}';
  }
}
