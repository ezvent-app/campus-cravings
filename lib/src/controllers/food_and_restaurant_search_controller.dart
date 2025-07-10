import 'package:campuscravings/src/models/User%20Model/nearby_restaurants_model.dart';
import 'package:campuscravings/src/models/catagory_viewing_model.dart';
import 'package:campuscravings/src/models/search_model.dart';
import 'package:campuscravings/src/repository/home_repository/search_repository.dart';
import 'package:campuscravings/src/src.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'location_controller.dart';

class FoodAndRestaurantSearchController extends GetxController {
  final SearchRepository _searchRepository;
  FoodAndRestaurantSearchController(this._searchRepository);
  SearchModel? _searchModel;

  List<FoodItem> _listOfFoodItemModel = [];
  List<FoodItem> get listOfFoodItemModel => _listOfFoodItemModel;

  NearbyRestaurantsResponse? _nearbyRestaurantsResponse;
  SearchModel? get searchModel => _searchModel;
  bool _isOperationInProgress = false, _searchFoodAndRestaurants = false;
  bool get isOperationInProgress => _isOperationInProgress;
  bool get searchFoodAndRestaurants => _searchFoodAndRestaurants;
  final _searchTextEditingController = TextEditingController();
  TextEditingController get searchTextEditingController =>
      _searchTextEditingController;
  bool _sortByFastDelivery = false;
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  bool get sortByFastDelivery => _sortByFastDelivery;
  CategoryViewingModel? _categoryViewingModel;
  CategoryViewingModel? get categoryViewingModel => _categoryViewingModel;

  Future<void> fetchAllCategories(BuildContext context) async {
    try {
      _isOperationInProgress = true;
      update();

      while (Get.find<LocationController>().isOperationInProgress) {
        await Future.delayed(const Duration(milliseconds: 100));
      }

      final location = await Get.find<LocationController>()
          .getCurrentLocation();
      if (location == null) {
        if (context.mounted) {
          showToast("Unable to get location", context: context);
        }
        _isOperationInProgress = false;
        update();
        return;
      }

      _categoryViewingModel = await _searchRepository.displayCategoriesName(
        lat: location.latitude,
        lng: location.longitude,
      );

      // Logger().i(
      //   "Fetched ${_categoryViewingModel?._categories.length ?? 0} categories",
      // );

      _isOperationInProgress = false;
      update();
    } catch (e) {
      Logger().e("Error fetching categories: $e");
      _isOperationInProgress = false;
      update();
    }
  }

  Future<void> getSearchResults(BuildContext context) async {
    try {
      if (_searchTextEditingController.text.trim().isEmpty) {
        if (context.mounted) showToast("Text is empty", context: context);
        return;
      }
      _isOperationInProgress = true;
      update();
      while (Get.find<LocationController>().isOperationInProgress) {
        await Future.delayed(const Duration(milliseconds: 100));
      }
      final location = await Get.find<LocationController>()
          .getCurrentLocation();
      if (location == null) {
        _isOperationInProgress = false;
        update();
        return;
      }
      _searchModel = await _searchRepository.searchFoodOrRestaurants(
        search: _searchTextEditingController.text.trim(),
        lat: location.latitude,
        lng: location.longitude,
      );
      _isOperationInProgress = false;
      update();
      return;
    } catch (e) {
      _isOperationInProgress = false;
      update();
      return;
    }
  }

  Future<void> getSearchCategory(
    BuildContext context,
    String categoryName,
  ) async {
    try {
      _isOperationInProgress = true;
      update();

      while (Get.find<LocationController>().isOperationInProgress) {
        await Future.delayed(const Duration(milliseconds: 100));
      }

      final location = await Get.find<LocationController>()
          .getCurrentLocation();
      if (location == null) {
        Logger().w("Location not found.");
        _isOperationInProgress = false;
        update();
        return;
      }

      _nearbyRestaurantsResponse = await _searchRepository.searchCategory(
        search: categoryName,
        lat: location.latitude,
        lng: location.longitude,
      );

      Logger().i(
        "Total categories: ${_nearbyRestaurantsResponse?.searchResult.categories.length}",
      );

      final matchingCategories = _nearbyRestaurantsResponse
          ?.searchResult
          .categories
          .where(
            (cat) =>
                cat.name.trim().toLowerCase() ==
                categoryName.trim().toLowerCase(),
          )
          .toList();

      Logger().i(
        "Matched ${matchingCategories?.length} categories for '$categoryName'",
      );

      _listOfFoodItemModel =
          matchingCategories?.expand((cat) => cat.items).toList() ?? [];

      Logger().i("Total items loaded: ${_listOfFoodItemModel.length}");

      _isOperationInProgress = false;
      update();
    } catch (e) {
      Logger().e("Error in getSearchCategory: $e");
      _isOperationInProgress = false;
      update();
    }
  }

  void setSortByFastDelivery({required bool value}) {
    _sortByFastDelivery = value;
    update();
  }

  void setSelectedIndex({required int index}) {
    _selectedIndex = index;
    update();
  }

  void setSearchFoodAndRestaurants({required bool value}) {
    _searchFoodAndRestaurants = value;
    _searchModel = null;
    _searchTextEditingController.clear();
  }

  void mapSelectedCategory({required String category}) {
    _searchTextEditingController.text = category;
    _searchFoodAndRestaurants = false;
  }

  @override
  void onClose() {
    _searchTextEditingController.dispose();
    super.onClose();
  }

  String getRestaurantTimingForToday({
    required RestaurantSearchModel restaurant,
  }) {
    {
      final now = DateTime.now();
      if (now.weekday == DateTime.monday) {
        return restaurant.openingHours.monday;
      } else if (now.weekday == DateTime.tuesday) {
        return restaurant.openingHours.tuesday;
      } else if (now.weekday == DateTime.wednesday) {
        return restaurant.openingHours.wednesday;
      } else if (now.weekday == DateTime.thursday) {
        return restaurant.openingHours.thursday;
      } else if (now.weekday == DateTime.friday) {
        return restaurant.openingHours.friday;
      } else if (now.weekday == DateTime.saturday) {
        return restaurant.openingHours.saturday;
      }
      return restaurant.openingHours.sunday;
    }
  }

  double getDistanceInMiles({required double lat, required double lng}) {
    if (Get.find<LocationController>().locationData == null) return 0.0;
    final data = Get.find<LocationController>().locationData;
    return (Geolocator.distanceBetween(
          data!.latitude,
          data!.longitude,
          lat,
          lng,
        )) /
        1609.344;
  }
}
