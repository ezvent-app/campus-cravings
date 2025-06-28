import 'package:campuscravings/src/controllers/food_and_restaurant_search_controller.dart';
import 'package:campuscravings/src/src.dart';
import 'package:campuscravings/src/ui/pages/main/tabs/home/search_page.dart';
import 'package:campuscravings/src/ui/pages/main/tabs/home/widgets/category_items_displaying_widget.dart';
import 'package:get/get.dart';

class CategoriesHorizontalWidget extends ConsumerStatefulWidget {
  const CategoriesHorizontalWidget({super.key});

  @override
  ConsumerState createState() => _CategoriesHorizontalWidgetState();
}

class _CategoriesHorizontalWidgetState
    extends ConsumerState<CategoriesHorizontalWidget> {
  final categories = [
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
    return Column(
      children: [
        Container(
          height: 180,
          width: double.infinity,
          padding: const EdgeInsets.only(top: 30, bottom: 20),
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: categories.length,
            separatorBuilder:
                (BuildContext context, int index) => const SizedBox(width: 8),
            itemBuilder: (BuildContext context, int index) {
              final category = categories[index];
              final imageName =
                  'category_${category.toLowerCase().replaceAll(' ', '_').replaceAll('&', 'and')}';
              return InkWellButtonWidget(
                onTap: () {
                  final selectedCategory = category;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => CategoryDisplayingPage(
                            category: selectedCategory,
                          ),
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
                      child: PngAsset(imageName, width: 50, height: 50),
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
