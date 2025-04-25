import 'package:campuscravings/src/controllers/location_controller.dart';
import 'package:campuscravings/src/repository/home_repository/restaurant_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../models/restaurant_details_model.dart';

class RestaurantDetailsController extends GetxController{

  final RestaurantRepository _restaurantRepository;
  RestaurantDetailsController(this._restaurantRepository);
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String _restaurantId = '';
  RestaurantDetailsModel? _restaurantDetailsModel;
  RestaurantDetailsModel? get restaurantDetails => _restaurantDetailsModel;
  String get restaurantId => _restaurantId;


  void setRestaurantId(String restaurantId){
    _restaurantId = restaurantId;
  }
  Future<void> getRestaurantDetails() async{
    try{
      _isLoading = true;
      update();
      Logger().w(_restaurantId);
      _restaurantDetailsModel = await _restaurantRepository.getRestaurantAllCategories(restaurantId: _restaurantId);
      _isLoading = false;
      update();
      return;
    }catch(e){
      _isLoading = false;
      update();
      return;
    }
  }
  double getDistanceInMiles() {
    final location = Get.find<LocationController>().locationData;
    if(location == null || _restaurantDetailsModel == null) return 0.0;
    return (Geolocator.distanceBetween(24.5113,67.6221, _restaurantDetailsModel!.restaurant.addresses.coordinates.coordinates[1], _restaurantDetailsModel!.restaurant.addresses.coordinates.coordinates[0])) / 1609.344;
  }
  bool checkIfDeliveryAvailable() {
    if(_restaurantDetailsModel == null) return false;
    //if(_restaurantDetailsModel!.restaurant.deliveryAvailable == null) return false;
    //if(_restaurantDetailsModel!.restaurant.deliveryAvailable == 'false') return false;
    return true;
  }
  int getCategoriesLength() {
    if(_restaurantDetailsModel == null) return 0;
    return _restaurantDetailsModel!.categories.length;
  }
}