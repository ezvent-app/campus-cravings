import 'package:auto_route/auto_route.dart';
import 'package:campus_cravings/constants/app_colors.dart';
import 'package:campus_cravings/router/router.gr.dart';
import 'package:campus_cravings/ui/widgets/png_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.tabBar(
      routes: const [
        HomeTab(),
        OrdersTab(),
        ProfileTab(),
      ],
      builder: (context, child, tabController) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(child: child),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 60)],
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12))
                ),
                height: 64,
                width: double.infinity,
                child: TabBar(
                  indicatorColor: Colors.transparent,
                  controller: tabController,

                  tabs: [
                    Tab(
                      icon: PngAsset(
                        'home_icon',
                        width: 25,
                        color: tabController.index == 0 ? Colors.black : AppColors.unselectedTabIconColor,
                      ),
                    ),
                    Tab(
                      icon: PngAsset(
                        'orders_icon',
                        width: 25,
                        color: tabController.index == 1 ? Colors.black : AppColors.unselectedTabIconColor,
                      ),
                    ),
                    Tab(
                      icon: PngAsset(
                        'profile_icon',
                        width: 25,
                        color: tabController.index == 2 ? Colors.black : AppColors.unselectedTabIconColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}