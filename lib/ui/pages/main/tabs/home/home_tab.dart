import 'package:auto_route/auto_route.dart';
import 'package:campus_cravings/constants/app_colors.dart';
import 'package:campus_cravings/ui/pages/main/tabs/home/widgets/categories_horizontal_widget.dart';
import 'package:campus_cravings/ui/pages/main/tabs/home/widgets/nearby_restaurants_widget.dart';
import 'package:campus_cravings/ui/pages/main/tabs/home/widgets/popular_horizontal_widget.dart';
import 'package:campus_cravings/ui/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class HomeTab extends ConsumerStatefulWidget{
  const HomeTab({super.key});

  @override
  ConsumerState createState() => _HomeTabState();
}

class _HomeTabState extends ConsumerState<HomeTab> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(25),
              child: Text('Discover',
                style: TextStyle(
                  color: Color(0xff443A39),
                  fontSize: 36,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  const Expanded(
                    child: CustomTextField(
                      style: TextStyle(fontSize: 17),
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Color(0xFFB4B0B0), fontSize: 17),
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: ImageIcon(AssetImage('assets/images/png/search_icon.png'), color: Color(0xFFB4B0B0), size: 30),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: 57, height: 57,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(color: AppColors.textFieldBorder, width: 2),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: (){},
                        child: const Center(
                          child: ImageIcon(AssetImage('assets/images/png/filter_icon.png'), color: Color(0xff443A39), size: 30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: const [
                  CategoriesHorizontalWidget(),
                  PopularHorizontalWidget(),
                  NearbyRestaurantsWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}