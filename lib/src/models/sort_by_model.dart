import 'package:campuscravings/src/controllers/food_and_restaurant_search_controller.dart';
import 'package:campuscravings/src/src.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../controllers/resturant_controller.dart';

class SortByModel {
  final String title;
  final int index;

  SortByModel({required this.title, required this.index});
}

List<SortByModel> sortByList = [
  SortByModel(title: 'Relevance (default)', index: 0),
  SortByModel(title: 'Fast Delivery', index: 1),
];

void showSortBottomSheet(BuildContext context) {
  final controller = Get.find<FoodAndRestaurantSearchController>();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return GetBuilder<FoodAndRestaurantSearchController>(
        builder: (controller) {
          return SizedBox(
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                height(20),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Sort by",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    itemCount: sortByList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final sort = sortByList[index];
                      final isSelected = controller.selectedIndex == sort.index;

                      return InkWellButtonWidget(
                        onTap: () {
                          controller.setSelectedIndex(index: sort.index);
                          controller.setSortByFastDelivery(value: sort.title == "Fast Delivery");
                        },
                        child: ListTile(
                          splashColor: Colors.transparent,
                          selectedColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          title: Text(
                            sort.title,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          trailing: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: isSelected ? Colors.black : Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: isSelected
                                ? Center(
                              child: Container(
                                width: 5,
                                height: 5,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            )
                                : const SizedBox(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

