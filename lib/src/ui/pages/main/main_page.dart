import 'package:campuscravings/src/src.dart';

import '../../../constants/storageHelper.dart';

@RoutePage()
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.tabBar(
      routes: [
        HomeTabRoute(),
        OrdersTabRoute(),
        CartTabRoute(isFromNavBar: true),
        StorageHelper().getRiderProfilefileComplete() == true
            ? RidersTabRoute()
            : DeliveryRegistrationRoute(),

        ProfileTabRoute(),
      ],
      builder: (context, child, tabController) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(child: child),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 60)],
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                ),
                height: 78,
                width: double.infinity,
                child: TabBar(
                  indicatorColor: Colors.transparent,
                  controller: tabController,
                  dividerColor: Colors.transparent,
                  tabs: [
                    _buildTab(
                      tabController,
                      0,
                      Images.home,
                      tabController.index == 0,
                    ),
                    _buildTab(
                      tabController,
                      1,
                      Images.docs,
                      tabController.index == 1,
                    ),
                    _buildTab(
                      tabController,
                      2,
                      Images.cart,
                      tabController.index == 2,
                    ),
                    _buildTab(
                      tabController,
                      3,
                      Images.delivery,
                      tabController.index == 3,
                    ),
                    _buildTab(
                      tabController,
                      4,
                      Images.profile,
                      tabController.index == 4,
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

  Widget _buildTab(
    TabController tabController,
    int index,
    String image,
    bool isSelected,
  ) {
    return Tab(
      icon: AnimatedScale(
        duration: const Duration(milliseconds: 200),
        scale: isSelected ? 1.2 : 1.0,
        child: SvgAssets(
          image,
          color:
              isSelected ? AppColors.black : AppColors.unselectedTabIconColor,
        ),
      ),
    );
  }
}
