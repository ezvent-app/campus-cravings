import 'dart:math';
import 'package:campuscravings/src/controllers/food_and_restaurant_search_controller.dart';
import 'package:campuscravings/src/controllers/location_controller.dart';
import 'package:campuscravings/src/models/near_by_restaurant_model.dart';
import 'package:campuscravings/src/repository/home_repository/restaurant_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../constants/get_builder_id_constants.dart';

class RestaurantController extends GetxController {
  final RestaurantRepository _restaurantRepository;
  RestaurantController(this._restaurantRepository);
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Position? _locationData;
  List<NearByRestaurantModel> _listOfNearByRestaurants = [];
  List<NearByRestaurantModel> get listOfNearByRestaurants =>
      _listOfNearByRestaurants;

  Future<void> getNearByRestaurants() async {
    try {
      _isLoading = true;
      update([nearByRestaurantBuilderId]);
      while (Get.find<LocationController>().isOperationInProgress) {
        await Future.delayed(Duration(milliseconds: 1500));
      }
      _locationData = await Get.find<LocationController>().getCurrentLocation();
      if (_locationData == null) {
        _isLoading = false;
        update([nearByRestaurantBuilderId]);
        return;
      }
      _listOfNearByRestaurants =
          (await _restaurantRepository.getNearByRestaurants(
            lat: _locationData!.latitude,
            lng: _locationData!.longitude,
          )) ??
          [];
      for (var element in _listOfNearByRestaurants) {
        element.address = Address(
          address: "ss",
          coordinates: Coordinates(
            type: "type",
            coordinates:
                saddarCoordinates[Random().nextInt(saddarCoordinates.length)],
          ),
        );
      }
      _isLoading = false;
      update([nearByRestaurantBuilderId]);
      return;
      // Logger().i(data!.length);
    } catch (e) {
      Logger().i(e);
      _isLoading = false;
      update([nearByRestaurantBuilderId]);
      return;
    }
  }

  double getDistanceInMiles({required double lat, required double lng}) {
    if (_locationData == null) return 0.0;
    return (Geolocator.distanceBetween(
          _locationData!.latitude,
          _locationData!.longitude,
          lat,
          lng,
        )) /
        1609.344;
  }

  String getRestaurantTimingForToday({
    required NearByRestaurantModel restaurant,
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

  List<List<double>> saddarCoordinates = [
    [73.0479, 33.5973], // Saddar Bazaar
    [73.0551, 33.6005], // Committee Chowk
    [73.0515, 33.5990], // Bank Road
    [73.0467, 33.5945], // Murree Road
    [73.0423, 33.5951], // Saddar Main Bazar
    [73.0500, 33.5967], // Adamjee Road
    [73.0492, 33.5982], // Raja Bazaar
    [73.0570, 33.6020], // Peshawar Road
    [73.0526, 33.6033], // Liaquat Road
    [73.0604, 33.6013], // Mall Road
  ];

  List<NearByRestaurantModel> getFilteredRestaurants() {
    if (Get.find<FoodAndRestaurantSearchController>().sortByFastDelivery ==
        false) {
      return _listOfNearByRestaurants;
    }
    return List<NearByRestaurantModel>.from(_listOfNearByRestaurants)..sort(
      (a, b) => getDistanceInMiles(
        lat: a.address.coordinates.coordinates[1],
        lng: a.address.coordinates.coordinates[0],
      ).compareTo(
        getDistanceInMiles(
          lat: b.address.coordinates.coordinates[1],
          lng: b.address.coordinates.coordinates[0],
        ),
      ),
    );
  }
}
