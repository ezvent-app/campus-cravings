import 'package:campuscravings/src/controllers/food_and_restaurant_search_controller.dart';
import 'package:campuscravings/src/src.dart';
import 'package:campuscravings/src/ui/pages/main/tabs/home/widgets/category_items_displaying_widget.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CategoriesHorizontalWidget extends StatelessWidget {
  const CategoriesHorizontalWidget({super.key});

  final List<String> allCategories = const [
    'Fast Food',
    'Burgers',
    'Pizza',
    'Rolls & Shawarma',
    'Sandwiches & Subs',
    'Pasta',
    'BBQ',
    'Rice',
    'Noodles & Soups',
    'Salads',
    'Desserts',
    'Ice Cream & Frozen Yogurt',
    'Juices & Smoothies',
    'Coffee & Tea',
    'Bakery & Cakes',
    'Seafood',
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FoodAndRestaurantSearchController>(
      initState: (_) {
        Get.find<FoodAndRestaurantSearchController>().fetchAllCategories(
          context,
        );
      },
      builder: (controller) {
        final isLoading = controller.isOperationInProgress;
        final apiCategories = controller.categoryViewingModel?.categories ?? [];

        final apiNames = apiCategories
            .map((e) => e.name?.toLowerCase().trim())
            .toSet();

        final filteredCategories = allCategories
            .where((cat) => apiNames.contains(cat.toLowerCase().trim()))
            .toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            height(20),
            Container(
              height: 150,
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 20),
              child: isLoading
                  ? _buildShimmer()
                  : filteredCategories.isEmpty
                  ? const Center(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            'No items are currently available from the restaurants under their respective categories',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xff565C67),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: filteredCategories.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final category = filteredCategories[index];
                        final imageName =
                            'category_${category.toLowerCase().replaceAll(' ', '_').replaceAll('&', 'and')}';

                        return InkWellButtonWidget(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CategoryDisplayingPage(category: category),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 90,
                                height: 90,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFFF4F4F6),
                                ),
                                child: PngAsset(
                                  imageName,
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                _formatCategory(category),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Color(0xff565C67),
                                  fontSize: 12,
                                  height: 1.2,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildShimmer() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      scrollDirection: Axis.horizontal,
      itemCount: 6,
      separatorBuilder: (_, __) => const SizedBox(width: 8),
      itemBuilder: (_, __) {
        return Column(
          children: [
            Shimmer.fromColors(
              baseColor: const Color(0xffE0E0E0),
              highlightColor: const Color(0xffF5F5F5),
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Shimmer.fromColors(
              baseColor: const Color(0xffE0E0E0),
              highlightColor: const Color(0xffF5F5F5),
              child: Container(width: 70, height: 12, color: Colors.white),
            ),
          ],
        );
      },
    );
  }

  String _formatCategory(String category) {
    final words = category.split(' ');
    if (words.length > 2) {
      final midIndex = (words.length / 2).ceil();
      return '${words.sublist(0, midIndex).join(' ')}\n${words.sublist(midIndex).join(' ')}';
    } else {
      return category;
    }
  }
}
