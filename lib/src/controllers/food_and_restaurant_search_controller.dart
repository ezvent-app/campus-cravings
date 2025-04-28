import 'package:campuscravings/src/models/search_model.dart';
import 'package:campuscravings/src/repository/home_repository/search_repository.dart';
import 'package:campuscravings/src/src.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'location_controller.dart';

class FoodAndRestaurantSearchController extends GetxController{

  final SearchRepository _searchRepository;
  FoodAndRestaurantSearchController(this._searchRepository);
  SearchModel? _searchModel;
  SearchModel? get searchModel => _searchModel;
  bool _isOperationInProgress = false, _searchFoodAndRestaurants = false;
  bool get isOperationInProgress => _isOperationInProgress;
  bool get searchFoodAndRestaurants => _searchFoodAndRestaurants;
  final _searchTextEditingController = TextEditingController();
  TextEditingController get searchTextEditingController => _searchTextEditingController;

  Future<void> getSearchResults(BuildContext context) async{
    try {
      if(_searchTextEditingController.text.trim().isEmpty){
        if(context.mounted) showToast("Text is empty", context: context);
        return;
      }
     _isOperationInProgress = true;
     while(Get.find<LocationController>().isOperationInProgress) {
       await Future.delayed(const Duration(milliseconds: 100));
     }
     final location = await Get.find<LocationController>().getCurrentLocation();
     if(location == null){
       _isOperationInProgress = false;
       update();
       return;
     }
     _searchModel = await _searchRepository.searchFoodOrRestaurants(search: _searchTextEditingController.text.trim(), lat: location.latitude, lng: location.longitude);
     _isOperationInProgress = false;
     update();
     return;
    }catch(e){
      _isOperationInProgress = false;
      update();
      return;
    }
  }

  void setSearchFoodAndRestaurants({required bool value}){
    _searchFoodAndRestaurants = value;
    _searchModel = null;
    _searchTextEditingController.clear();
  }
  void mapSelectedCategory({required String category}){
    _searchTextEditingController.text = category;
    _searchFoodAndRestaurants = false;
  }

  @override
  void onClose() {
    _searchTextEditingController.dispose();
    super.onClose();
  }

  String getRestaurantTimingForToday({required RestaurantSearchModel restaurant}) {
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
  double getDistanceInMiles({required double lat, required double lng}){
    if(Get.find<LocationController>().locationData == null) return 0.0;
    final data = Get.find<LocationController>().locationData;
    return (Geolocator.distanceBetween(data!.latitude,data!.longitude, lat, lng)) / 1609.344;
  }
}