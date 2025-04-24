import 'package:campuscravings/src/controllers/product_catalog_controller.dart';
import 'package:campuscravings/src/src.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../constants/get_builder_id_constants.dart';
import '../../../../../widgets/custom_network_image.dart';

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
    'Cheese Pizza',
  ];
  @override
  Widget build(BuildContext context) {
    Get.find<ProductCatalogController>().getPopularItems();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 25),
          child: Text(
            'Popular Items',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        GetBuilder<ProductCatalogController>(
            initState: (state){
              Get.find<ProductCatalogController>().getPopularItems();
            },
            id: popularItemBuilderId,
            builder: (controller){
              if(controller.isLoading) {
                return productListShimmer();
              }
              else if(controller.isLoading == false && controller.listOfPopularItems.isEmpty) {
                return const Center(
                  child: Text('No popular items found'),
                );
              }
              return SizedBox(
                height: 227,
                width: double.infinity,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: controller.listOfPopularItems.length,
                  separatorBuilder: (BuildContext context, int index) => width(12),
                  itemBuilder: (BuildContext context, int index) {
                    final item = controller.listOfPopularItems[index];
                    return InkWell(
                      onTap: (){
                        controller.mapSelectedProductItem(item);
                        context.pushRoute(
                          RestaurantRoute()
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: .08),
                                  blurRadius: 15,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                CustomNetworkImage(
                                  item.itemDetails.image[0],
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.cover,
                                ),
                                //const PngAsset('mock_product_2', width: 90, height: 90),
                                height(14),
                                Text(
                                  item.itemDetails.name,
                                  style: const TextStyle(
                                    color: AppColors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
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
                                    Text(
                                      '${item.itemDetails.estimatedPreparationTime}min',
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
                                  '\$${item.itemDetails.price}',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }
        ),
      ],
    );
  }

  Widget productListShimmer() {
    return SizedBox(
      height: 227,
      width: double.infinity,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: 5, // number of shimmer cards
        separatorBuilder: (BuildContext context, int index) => width(12),
        itemBuilder: (BuildContext context, int index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      height(14),
                      Container(
                        width: 70,
                        height: 12,
                        color: Colors.white,
                      ),
                      height(8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(width: 10, height: 10, color: Colors.white),
                          width(5),
                          Container(width: 30, height: 8, color: Colors.white),
                          width(5),
                          Container(
                            width: 4,
                            height: 4,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                          width(5),
                          Container(width: 10, height: 10, color: Colors.white),
                          width(5),
                          Container(width: 20, height: 8, color: Colors.white),
                        ],
                      ),
                      height(10),
                      Container(
                        width: 50,
                        height: 12,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
}
}
