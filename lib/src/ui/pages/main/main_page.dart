import 'package:campus_cravings/src/src.dart';

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
        HomeTabRoute(),
        OrdersTabRoute(),
        ProfileTabRoute(),
        RidersTabRoute(),
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
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 60)
                    ],
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(12))),
                height: 64,
                width: double.infinity,
                child: TabBar(
                  indicatorColor: Colors.transparent,
                  controller: tabController,
                  tabs: [
                    Tab(
                        icon: SvgAssets(
                      Images.home,
                      color: tabController.index == 0
                          ? AppColors.black
                          : AppColors.unselectedTabIconColor,
                    )),
                    Tab(
                        icon: SvgAssets(
                      Images.docs,
                      color: tabController.index == 1
                          ? AppColors.black
                          : AppColors.unselectedTabIconColor,
                    )),
                    Tab(
                        icon: CartCounterWidget(
                            count: 2,
                            color: tabController.index == 2
                                ? AppColors.black
                                : AppColors.unselectedTabIconColor)),
                    Tab(
                        icon: SvgAssets(
                      Images.delivery,
                      color: tabController.index == 3
                          ? AppColors.black
                          : AppColors.unselectedTabIconColor,
                    )),
                    Tab(
                        icon: SvgAssets(
                      Images.profile,
                      color: tabController.index == 4
                          ? AppColors.black
                          : AppColors.unselectedTabIconColor,
                    )),
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
