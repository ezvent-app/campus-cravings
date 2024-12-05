import 'package:auto_route/auto_route.dart';
import 'package:campus_cravings/constants/app_colors.dart';
import 'package:campus_cravings/ui/widgets/png_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class HomeTab extends ConsumerStatefulWidget {
  const HomeTab({super.key});

  @override
  ConsumerState createState() => _HomeTabState();
}

class _HomeTabState extends ConsumerState<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            width: double.infinity,
            height: 400,
            child: const PngAsset('mock_product_1', fit: BoxFit.fitWidth,)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Big Garded Salad',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600
                  ),
                ),
                const Divider(color: AppColors.dividerColor, height: 30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const PngAsset('location_pin'),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '1 mile away',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        const SizedBox(height: 3),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Delivery Available',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.lightText,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10,),
                              width: 2,
                              height: 20,
                              color: AppColors.lightText,
                            ),
                            const PngAsset('travel_icon', width: 25),
                            const SizedBox(width: 10),
                            const Text(
                              '\$2.00',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.lightText,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(color: AppColors.dividerColor, height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}