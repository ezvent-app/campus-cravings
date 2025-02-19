import 'package:campus_cravings/src/src.dart';

class PopularHorizontalWidget extends ConsumerStatefulWidget {
  const PopularHorizontalWidget({super.key});

  @override
  ConsumerState createState() => _PopularHorizontalWidgetState();
}

class _PopularHorizontalWidgetState
    extends ConsumerState<PopularHorizontalWidget> {
  final products = [
    'Cheese Pizza',
    'Cheese Pizza',
    'Cheese Pizza',
    'Cheese Pizza'
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 25),
          child: Text('Popular Items',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  )),
        ),
        SizedBox(
          height: 227,
          width: double.infinity,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            separatorBuilder: (BuildContext context, int index) => width(12),
            itemBuilder: (BuildContext context, int index) {
              final category = products[index];
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withValues(alpha: .08),
                              blurRadius: 15)
                        ]),
                    child: Column(
                      children: [
                        const PngAsset(
                          'mock_product_2',
                          width: 90,
                          height: 90,
                        ),
                        height(14),
                        Text(
                          category,
                          style: const TextStyle(
                              color: AppColors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SvgAssets(
                              'linear_clock',
                              width: 10,
                              height: 10,
                            ),
                            width(3),
                            const Text(
                              '25min',
                              style: TextStyle(
                                color: AppColors.lightText,
                                fontSize: 10,
                              ),
                            ),
                            Container(
                              width: 4,
                              height: 4,
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFD9D9D9),
                              ),
                            ),
                            const SvgAssets(
                              'linear_star',
                              width: 10,
                              height: 10,
                            ),
                            width(3),
                            const Text(
                              '4.7',
                              style: TextStyle(
                                color: AppColors.lightText,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                        height(2),
                        Text(
                          '\$6.90',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
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
