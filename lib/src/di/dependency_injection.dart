import 'package:campuscravings/src/controllers/location_controller.dart';
import 'package:campuscravings/src/controllers/product_catalog_controller.dart';
import 'package:campuscravings/src/controllers/product_details_controller.dart';
import 'package:campuscravings/src/controllers/restaurant_details_controller.dart';
import 'package:campuscravings/src/controllers/resturant_controller.dart';
import 'package:campuscravings/src/controllers/food_and_restaurant_search_controller.dart';
import 'package:campuscravings/src/repository/home_repository/product_catalog_repository.dart';
import 'package:campuscravings/src/repository/home_repository/restaurant_repository.dart';
import 'package:campuscravings/src/repository/home_repository/search_repository.dart';
import 'package:campuscravings/src/services/http_api_services.dart';
import 'package:campuscravings/src/services/location_service.dart';
import 'package:get/get.dart';

class DependencyInjection {

  static void initialize(){

    Get.lazyPut<LocationService>(() => LocationService());

    Get.lazyPut<ProductRepository>(() => ProductRepository(HttpAPIServices()));
    Get.lazyPut<RestaurantRepository>(() => RestaurantRepository(HttpAPIServices()));
    Get.lazyPut<SearchRepository>(() => SearchRepository(HttpAPIServices()));
    Get.put(LocationController(Get.find<LocationService>()),permanent: true);
    Get.put(ProductCatalogController(Get.find<ProductRepository>()),permanent: true);
    Get.put(RestaurantController(Get.find<RestaurantRepository>()),permanent: true);
    Get.lazyPut<RestaurantDetailsController>(() => RestaurantDetailsController(Get.find<RestaurantRepository>()), fenix: true);
    Get.lazyPut<ProductDetailsController>(() => ProductDetailsController(Get.find<ProductRepository>()), fenix: true);
    Get.lazyPut<FoodAndRestaurantSearchController>(() => FoodAndRestaurantSearchController(Get.find<SearchRepository>()), fenix: true);
  }
  // static final DependencyInjection _instance = DependencyInjection._internal();
  //
  // factory DependencyInjection() {
  //   return _instance;
  // }
  //
  // DependencyInjection._internal();
  //
  // // Add your dependencies here
  // // Example:
  // // final SomeService someService = SomeService();
}