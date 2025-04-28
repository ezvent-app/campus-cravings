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

  int getCategoriesLength() {
    if(_restaurantDetailsModel == null) return 0;
    return _restaurantDetailsModel!.categories.length;
  }

  String getRestaurantTimingForToday() {
    final now = DateTime.now();
    if (now.weekday == DateTime.monday) {
      return _restaurantDetailsModel!.restaurant.openingHours.monday;
    } else if (now.weekday == DateTime.tuesday) {
      return _restaurantDetailsModel!.restaurant.openingHours.tuesday;
    } else if (now.weekday == DateTime.wednesday) {
      return _restaurantDetailsModel!.restaurant.openingHours.wednesday;
    } else if (now.weekday == DateTime.thursday) {
      return _restaurantDetailsModel!.restaurant.openingHours.thursday;
    } else if (now.weekday == DateTime.friday) {
      return _restaurantDetailsModel!.restaurant.openingHours.friday;
    } else if (now.weekday == DateTime.saturday) {
      return _restaurantDetailsModel!.restaurant.openingHours.saturday;
    }
    return _restaurantDetailsModel!.restaurant.openingHours.sunday;
  }
  bool isRestaurantOpen() {
    final restaurantTime = getRestaurantTimingForToday();
    if (restaurantTime == 'closed') return false;
    final parts = restaurantTime.split('-');
    if (parts.length != 2) return false;

    final now = DateTime.now();
    final openParts = parts[0].split(':');
    final closeParts = parts[1].split(':');

    final openTime = DateTime(now.year, now.month, now.day,
        int.parse(openParts[0]), int.parse(openParts[1]));

    final closeTime = DateTime(now.year, now.month, now.day,
        int.parse(closeParts[0]), int.parse(closeParts[1]));

    return now.isAfter(openTime) && now.isBefore(closeTime);
  }

}