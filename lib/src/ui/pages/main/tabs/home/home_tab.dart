import 'package:campuscravings/src/constants/storageHelper.dart';
import 'package:campuscravings/src/controllers/food_and_restaurant_search_controller.dart';
import 'package:campuscravings/src/controllers/user_controller.dart';
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
  bool showFilterOverlay = false;
  String selectedSort = 'Relevance';

  final GlobalKey _filterRowKey = GlobalKey();
  Offset _filterOffset = Offset.zero;
  double _filterHeight = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final token = StorageHelper().getAccessToken();
      if (token != null) {
        final socketController = ref.read(socketControllerProvider);
        socketController.connect(token);
      } else {
        debugPrint("Token is null");
      }

      _getFilterOffset();
    });
  }

  void _getFilterOffset() {
    final RenderBox? renderBox =
        _filterRowKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      setState(() {
        _filterOffset = renderBox.localToGlobal(Offset.zero);
        _filterHeight = renderBox.size.height;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserController userController = ref.watch(
      userControllerProvider.notifier,
    );
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                height(20),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(2, 3),
                        blurRadius: 5,
                        color: Colors.grey.withOpacity(0.2),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.white,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  child: TextButton(
                    onPressed: () {
                      StorageHelper().getRiderProfilefileComplete() == true
                          ? context.pushRoute(RidersTabRoute())
                          : showToast(
                            context: context,
                            "Please register as a rider first to access this feature.",
                          );
                    },
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
                            "Orders are ready for you to pick up! Start earning with Campus Cravings today.",
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
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  key: _filterRowKey, // Add key here
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
                              MaterialPageRoute(
                                builder: (context) => SearchPage(),
                              ),
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
                            onTap: () {
                              _getFilterOffset();
                              setState(() {
                                showFilterOverlay = !showFilterOverlay;
                              });
                            },
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
                      height(20),
                      NearbyRestaurantsWidget(),
                    ],
                  ),
                ),
              ],
            ),

            //showSortBottomSheet(context) is not used in this code, so it has been removed the code is existing

            // Overlay positioned under filter+search row
            if (showFilterOverlay)
              Positioned(
                right: 22,
                top: _filterOffset.dy,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Material(
                    elevation: 6,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: 190,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: GetBuilder<FoodAndRestaurantSearchController>(
                        builder: (controller) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Sort by",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              ...sortByList.map((sort) {
                                // final isSelected =
                                //     controller.selectedIndex == sort.index;

                                return GestureDetector(
                                  onTap: () {
                                    controller.setSelectedIndex(
                                      index: sort.index,
                                    );
                                    controller.setSortByFastDelivery(
                                      value: sort.title == "Fast Delivery",
                                    );
                                    setState(() {
                                      selectedSort = sort.title;
                                      showFilterOverlay = false;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        sort.title,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Radio<int>(
                                        value: sort.index,
                                        groupValue: controller.selectedIndex,
                                        onChanged: (value) {
                                          controller.setSelectedIndex(
                                            index: value!,
                                          );
                                          controller.setSortByFastDelivery(
                                            value:
                                                sort.title == "Fast Delivery",
                                          );
                                          setState(() {
                                            selectedSort = sort.title;
                                            showFilterOverlay = false;
                                          });
                                        },
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
