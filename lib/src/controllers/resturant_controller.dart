import 'package:campuscravings/src/controllers/location_controller.dart';
import 'package:campuscravings/src/models/near_by_restaurant_model.dart';
import 'package:campuscravings/src/models/restaurant_details_model.dart';
import 'package:campuscravings/src/repository/home_repository/restaurant_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:logger/logger.dart';

import '../constants/get_builder_id_constants.dart';
import '../services/location_service.dart';

class RestaurantController extends GetxController{

  final RestaurantRepository _restaurantRepository;
  RestaurantController(this._restaurantRepository);
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  LocationData? _locationData;
  List<NearByRestaurantModel> _listOfNearByRestaurants = [];
  List<NearByRestaurantModel> get listOfNearByRestaurants => _listOfNearByRestaurants;

  Future<void> getNearByRestaurants() async{
    try{
      _isLoading = true;
      update([nearByRestaurantBuilderId]);
      if(Get.find<LocationController>().isOperationInProgress){
        await Future.delayed(Duration(seconds: 4));
      }
      _locationData = await Get.find<LocationController>().getCurrentLocation();
      Logger().i(_locationData);
      if(_locationData == null) {
        _isLoading = false;
        update([nearByRestaurantBuilderId]);
        return;
      }
      _listOfNearByRestaurants = (await _restaurantRepository.getNearByRestaurants(lat: _locationData!.latitude!, lng: _locationData!.longitude!)) ?? [];
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

}