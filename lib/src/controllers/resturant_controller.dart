import 'package:campuscravings/src/controllers/location_controller.dart';
import 'package:campuscravings/src/models/near_by_restaurant_model.dart';
import 'package:campuscravings/src/repository/home_repository/restaurant_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:logger/logger.dart';
import '../constants/get_builder_id_constants.dart';

class RestaurantController extends GetxController{

  final RestaurantRepository _restaurantRepository;
  RestaurantController(this._restaurantRepository);
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Position? _locationData;
  List<NearByRestaurantModel> _listOfNearByRestaurants = [];
  List<NearByRestaurantModel> get listOfNearByRestaurants => _listOfNearByRestaurants;

  Future<void> getNearByRestaurants() async{
    try{
      _isLoading = true;
      update([nearByRestaurantBuilderId]);
      while(Get.find<LocationController>().isOperationInProgress){
        await Future.delayed(Duration(milliseconds: 1500));
      }
      _locationData = await Get.find<LocationController>().getCurrentLocation();
      if(_locationData == null) {
        _isLoading = false;
        update([nearByRestaurantBuilderId]);
        return;
      }
      _listOfNearByRestaurants = (await _restaurantRepository.getNearByRestaurants(lat: _locationData!.latitude, lng: _locationData!.longitude)) ?? [];
      _isLoading = false;
      update([nearByRestaurantBuilderId]);
      return;
      // Logger().i(data!.length);
    }catch(e){
      Logger().i(e);
      _isLoading = false;
      update([nearByRestaurantBuilderId]);
      return;
    }
  }

  double getDistanceInMiles({required double lat, required double lng}){
    if(_locationData == null) return 0.0;
    return (Geolocator.distanceBetween(24.5113,67.6221, lat, lng)) / 1609.344;
  }

  String getRestaurantTimingForToday({required NearByRestaurantModel restaurant}) {
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
}