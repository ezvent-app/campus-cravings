import 'package:auto_route/auto_route.dart';
import 'package:campus_cravings/constants/app_colors.dart';
import 'package:campus_cravings/models/product/product.dart';
import 'package:campus_cravings/ui/widgets/png_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ProductDetailsPage extends ConsumerStatefulWidget {
  final Product product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  ConsumerState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends ConsumerState<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              const ClipRRect(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
                child: SizedBox(
                  width: double.infinity,
                  height: 350,
                  child: PngAsset('mock_product_1', fit: BoxFit.fitWidth),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30,),
                        onPressed: () {
                          context.maybePop();
                        },
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const ImageIcon(AssetImage('assets/images/png/shopping_bag_icon.png'), color: Colors.white, size: 28,),
                        onPressed: () {
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              children: [
                const Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hamburger',
                                  style: TextStyle(
                                    color: Color(0xff27261E),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Double Hamburger',
                                  style: TextStyle(
                                    color: Color(0xff27261E),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 20)
                    ]
                  ),
                  child: Row(
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '2 Items',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13
                            ),
                          ),
                          Text(
                            '\$ 12.99',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 49,
                        child: ElevatedButton.icon(
                          onPressed: (){},
                          label: const Text('Add to Cart'),
                          icon: const ImageIcon(AssetImage('assets/images/png/shopping_cart_icon.png'), size: 15),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.background,// Splash color
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}