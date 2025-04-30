import 'package:campuscravings/src/constants/storageHelper.dart';
import 'package:campuscravings/src/controllers/food_and_restaurant_search_controller.dart';
import 'package:campuscravings/src/repository/user_info_repo/user_info_repo.dart';
import 'package:campuscravings/src/src.dart';
import 'package:campuscravings/src/ui/pages/main/tabs/home/search_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

@RoutePage()
class HomeTabPage extends ConsumerStatefulWidget {
  const HomeTabPage({super.key});

  @override
  ConsumerState<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends ConsumerState<HomeTabPage> {
  @override
  void initState() {
    // TODO: implement
    UserInfoRepository info = UserInfoRepository();
    info.fetchUserProfile();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final token = StorageHelper().getAccessToken();
      if (token != null) {
        final socketController = ref.read(socketControllerProvider);
        socketController.connect(token);
      } else {
        debugPrint("Token is null");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    UserInfoRepository info = UserInfoRepository();
    info.fetchUserProfile();
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            height(20),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(2, 3),
                    blurRadius: 5,
                    color: Colors.grey.withValues(alpha: .5),
                  ),
                ],
                borderRadius: BorderRadius.circular(12),
                color: AppColors.white,
              ),
              margin: EdgeInsets.symmetric(horizontal: 25),
              child: TextButton(
                onPressed: () => context.pushRoute(RidersTabRoute()),
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            locale.deliverwithUs,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                      Text(
                        "6 orders are ready for you to pick up! Start earning with Campus Cravings today.",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(25),
              child: Text(
                locale.discover,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  Expanded(
                    child: InkWellButtonWidget(
                      onTap: () {
                        Get.find<FoodAndRestaurantSearchController>()
                            .setSearchFoodAndRestaurants(value: true);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SearchPage()),
                        );
                      },
                      child: AbsorbPointer(
                        child: CustomTextField(
                          style: TextStyle(fontSize: 17),
                          hintText: locale.search,
                          hintStyle: TextStyle(
                            color: Color(0xFFB4B0B0),
                            fontSize: 17,
                          ),
                          prefixIcon: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(
                              CupertinoIcons.search,
                              color: AppColors.email,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  width(16),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(
                        color: AppColors.textFieldBorder,
                        width: 2,
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWellButtonWidget(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () => showSortBottomSheet(context),
                        child: const Center(
                          child: SvgAssets("filter", width: 24, height: 24),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                children: [
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
