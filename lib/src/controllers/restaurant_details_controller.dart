import 'package:campuscravings/src/controllers/location_controller.dart';
import 'package:campuscravings/src/repository/home_repository/restaurant_repository.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../models/restaurant_details_model.dart';

class RestaurantDetailsController extends GetxController {
  final RestaurantRepository _restaurantRepository;

  RestaurantDetailsController(this._restaurantRepository);

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  String _restaurantId = '';
  RestaurantDetailsModel? _restaurantDetailsModel;

  RestaurantDetailsModel? get restaurantDetails => _restaurantDetailsModel;

  String get restaurantId => _restaurantId;

  void setRestaurantId(String restaurantId) {
    _restaurantId = restaurantId;
  }

  Future<void> getRestaurantDetails() async {
    try {
      _isLoading = true;
      update();
      Logger().w(_restaurantId);
      _restaurantDetailsModel = await _restaurantRepository
          .getRestaurantAllCategories(restaurantId: _restaurantId);
      _isLoading = false;
      update();
      return;
    } catch (e) {
      _isLoading = false;
      update();
      return;
    }
  }

  double getDistanceInMiles() {
    final location = Get
        .find<LocationController>()
        .locationData;
    if (location == null || _restaurantDetailsModel == null) return 0.0;
    return (Geolocator.distanceBetween(
      location.latitude,
      location.longitude,
      _restaurantDetailsModel!
          .restaurant
          .addresses
          .coordinates
          .coordinates[1],
      _restaurantDetailsModel!
          .restaurant
          .addresses
          .coordinates
          .coordinates[0],
    )) /
        1609.344;
  }

  int getCategoriesLength() {
    if (_restaurantDetailsModel == null) return 0;
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
    Logger().w(restaurantTime);
    if (restaurantTime.toLowerCase() == 'closed') return false;

    final parts = restaurantTime.split('-');
    if (parts.length != 2) return false;

    final now = DateTime.now();

    final openTime = _convertTo24HourTime(parts[0].trim());
    final closeTime = _convertTo24HourTime(parts[1].trim());

    final openDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      openTime.hour,
      openTime.minute,
    );

    var closeDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      closeTime.hour,
      closeTime.minute,
    );

    // Handle overnight closing (e.g. 8:00 PM - 2:00 AM)
    if (closeDateTime.isBefore(openDateTime)) {
      closeDateTime = closeDateTime.add(const Duration(days: 1));
    }

    return now.isAfter(openDateTime) && now.isBefore(closeDateTime);
  }

  TimeOfDay _convertTo24HourTime(String time) {
    final parts = time.split(' '); // ['9:00', 'AM']
    final timeParts = parts[0].split(':'); // ['9', '00']

    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);
    final period = parts[1].toUpperCase();

    if (period == 'PM' && hour != 12) {
      hour += 12;
    } else if (period == 'AM' && hour == 12) {
      hour = 0;
    }

    return TimeOfDay(hour: hour, minute: minute);
  }

}
