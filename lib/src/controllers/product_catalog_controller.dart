import 'package:campuscravings/src/constants/get_builder_id_constants.dart';
import 'package:campuscravings/src/controllers/location_controller.dart';
import 'package:campuscravings/src/models/product_item_model.dart';
import 'package:campuscravings/src/repository/home_repository/product_catalog_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'food_and_restaurant_search_controller.dart';

class ProductCatalogController extends GetxController {
  final ProductRepository _homeRepository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<ProductItemModel> _listOfPopularItems = [];
  List<ProductItemModel> get listOfPopularItems => _listOfPopularItems;
  ProductCatalogController(this._homeRepository);

  Future<void> getPopularItems() async {
    try {
      if (_listOfPopularItems.isNotEmpty) return;
      _isLoading = true;
      update([popularItemBuilderId]);
      while (Get.find<LocationController>().isOperationInProgress) {
        await Future.delayed(Duration(milliseconds: 500));
      }
      final location = await Get.find<LocationController>()
          .getCurrentLocation();
      if (location == null) {
        _isLoading = false;
        update([popularItemBuilderId]);
        return;
      }
      _listOfPopularItems =
          (await _homeRepository.getPopularItems(
            lat: location.latitude,
            lng: location.longitude,
          )) ??
          [];
      _isLoading = false;
      update([popularItemBuilderId]);
      return;
      // Logger().i(data!.length);
    } catch (e) {
      Logger().i(e);
      _isLoading = false;
      update([popularItemBuilderId]);
    }
    return;
  }

  List<ProductItemModel> getFilteredPopularItems() {
    if (Get.find<FoodAndRestaurantSearchController>().sortByFastDelivery ==
        false) {
      return _listOfPopularItems;
    }
    return List<ProductItemModel>.from(_listOfPopularItems)..sort(
      (a, b) =>
          getDistanceInMiles(
            lat: a.restaurant.addresses.coordinates.coordinates[1],
            lng: a.restaurant.addresses.coordinates.coordinates[0],
          ).compareTo(
            getDistanceInMiles(
              lat: b.restaurant.addresses.coordinates.coordinates[1],
              lng: b.restaurant.addresses.coordinates.coordinates[0],
            ),
          ),
    );
  }

  double getDistanceInMiles({required double lat, required double lng}) {
    final locationData = Get.find<LocationController>().locationData;
    if (locationData == null) return 0.0;
    return (Geolocator.distanceBetween(
          locationData.latitude,
          locationData.longitude,
          lat,
          lng,
        )) /
        1609.344;
  }
}
