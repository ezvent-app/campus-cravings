import 'package:campuscravings/src/controllers/location_controller.dart';
import 'package:campuscravings/src/repository/home_repository/restaurant_repository.dart';
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
    final location = Get.find<LocationController>().locationData;
    if (location == null || _restaurantDetailsModel == null) return 0.0;
    return (Geolocator.distanceBetween(
          24.5113,
          67.6221,
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

    // If the restaurant is closed
    if (restaurantTime == 'closed') return false;

    final parts = restaurantTime.split('-');
    if (parts.length != 2) return false;

    final now = DateTime.now();

    // Split the opening and closing time
    final openTime = _convertTo24HourTime(
      parts[0].trim(),
    ); // Pass full time with period
    final closeTime = _convertTo24HourTime(
      parts[1].trim(),
    ); // Pass full time with period

    // Parse open and close times into DateTime objects
    final openDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      openTime.hour,
      openTime.minute,
    );
    final closeDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      closeTime.hour,
      closeTime.minute,
    );

    // Check if current time is between open and close time
    return now.isAfter(openDateTime) && now.isBefore(closeDateTime);
  }

  // Helper function to convert time from 12-hour (AM/PM) format to 24-hour format
  DateTime _convertTo24HourTime(String timeWithPeriod) {
    // Split the time by space to separate the time and period (AM/PM)
    final timeParts = timeWithPeriod.split(' ');

    if (timeParts.length != 2) {
      throw FormatException("Invalid time format: $timeWithPeriod");
    }

    final time = timeParts[0]; // Hour:Minute
    final period = timeParts[1].toUpperCase(); // AM/PM

    final timeSplit = time.split(':');

    if (timeSplit.length != 2) {
      throw FormatException("Invalid time format: $time");
    }

    final hour = int.parse(timeSplit[0].trim());
    final minute = int.parse(timeSplit[1].trim());

    int h = hour;
    int m = minute;

    // Convert to 24-hour time
    if (period == 'AM' && h == 12) {
      h = 0; // Convert 12 AM to 00:00
    } else if (period == 'PM' && h != 12) {
      h += 12; // Convert PM hours to 24-hour format
    }

    return DateTime(0, 0, 0, h, m);
  }
}
