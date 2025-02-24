import 'package:campus_cravings/src/src.dart';

class CategoriesHorizontalWidget extends ConsumerStatefulWidget {
  const CategoriesHorizontalWidget({super.key});

  @override
  ConsumerState createState() => _CategoriesHorizontalWidgetState();
}

class _CategoriesHorizontalWidgetState
    extends ConsumerState<CategoriesHorizontalWidget> {
  final categories = ['Bread', 'Burger', 'Drink', 'Noodle'];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
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
              return Column(
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
                      'category_${category.toLowerCase()}',
                      width: 50,
                      height: 50,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    category,
                    style: const TextStyle(color: Color(0xff565C67)),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
