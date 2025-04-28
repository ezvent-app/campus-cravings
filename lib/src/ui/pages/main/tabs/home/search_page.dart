import 'package:campuscravings/src/controllers/food_and_restaurant_search_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../../../../src.dart';
import '../../../../widgets/custom_network_image.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin{

  late TabController _tabController;
  final _focusNode = FocusNode();

  @override
  initState(){
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Get.find<FoodAndRestaurantSearchController>().searchFoodAndRestaurants) {
        _focusNode.requestFocus();
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomTextField(
                  style: TextStyle(fontSize: 17),
                  dismissOnTapOutside: true,
                  controller: Get.find<FoodAndRestaurantSearchController>().searchTextEditingController,
                  focusNode: _focusNode,
                  onSubmitted: (value){
                    Get.find<FoodAndRestaurantSearchController>().getSearchResults(context);
                  },
                  hintText: "Search",
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
              height(10),
              TabBar(
               controller: _tabController,
               dividerColor: Colors.transparent,
               overlayColor: MaterialStateProperty.all(Colors.transparent),
               tabs: [
                  Text(
                   "Foods",
                   style: Theme.of(
                    context,
                ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w500)),
                 Text(
                     "Restaurants",
                     style: Theme.of(
                       context,
                     ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w500)),
                ],
              ),
              height(10),
              GetBuilder<FoodAndRestaurantSearchController>(
                  initState: (state){
                    if(Get.find<FoodAndRestaurantSearchController>().searchFoodAndRestaurants == false){
                      Get.find<FoodAndRestaurantSearchController>().getSearchResults(context);
                    }
                    //Logger().i("state");
                  },
                  builder: (controller){
                    if(controller.isOperationInProgress == false && controller.searchModel != null) {
                      return Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            _buildFoodsTabs(context,controller),
                            _buildRestaurantsTabs(context,controller),
                          ],
                        ),
                      );
                    }
                    return Container();
                  }
              ),

            ],
          ),

      ),
    );
  }

  Widget _buildFoodsTabs(BuildContext context,FoodAndRestaurantSearchController controller){
    if(controller.searchModel!.listOfFoodItemModel.isEmpty) {
      return Center(
         child: Text("No Food Items Found"
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      physics: BouncingScrollPhysics(),
      itemCount: controller.searchModel?.listOfFoodItemModel.length ?? 0,
      separatorBuilder: (BuildContext context, int index) => width(12),
      itemBuilder: (BuildContext context, int index) {
        final item = controller.searchModel?.listOfFoodItemModel[index];
        return InkWell(
          onTap: (){

          },
          child: Container(
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomNetworkImage(
                  "${item?.image[0]}",
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
                width(15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${item?.name}",
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
                          '${item?.estimatedPreparationTime} min',
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
                      ],
                    ),
                    height(2),
                    Text(
                      '\$${item?.price}',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                )
                //const PngAsset('mock_product_2', width: 90, height: 90),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRestaurantsTabs(BuildContext context, FoodAndRestaurantSearchController controller){
    if(controller.searchModel!.listOfNearByRestaurantModel.isEmpty) {
      return Center(
        child: Text("No Restaurants Found"
        ),
      );
    }
    return ListView.builder(
        itemCount: controller.searchModel?.listOfNearByRestaurantModel.length ?? 0,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context,index){
          final item = controller.searchModel?.listOfNearByRestaurantModel[index];
          return InkWellButtonWidget(
            onTap: () {
              // Get.find<RestaurantDetailsController>().setRestaurantId(
              //   restaurant.id,
              // );
              // context.pushRoute(const RestaurantRoute());
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 25,
              ),
              child: Row(
                children: [
                  CustomNetworkImage(
                    '${item!.restaurantImages.isEmpty ? '' : item.restaurantImages[0]}',
                    borderRadius: BorderRadius.circular(200),
                    fit: BoxFit.cover,
                    width: 110,
                    height: 110,
                  ),
                  const SizedBox(width: 25),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.45,
                        child: Text(
                          "${item?.brandName}",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xff443A39),
                          ),
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        "${item?.cuisine}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xffB4B0B0),
                        ),
                      ),
                      SizedBox(height: 7),
                      Text(
                        "${controller.getRestaurantTimingForToday(restaurant: item)} | ${controller.getDistanceInMiles(lat: item.addresses.coordinates.coordinates[1], lng: item.addresses.coordinates.coordinates[0]).toStringAsFixed(2)} mil away",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff443A39),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}


