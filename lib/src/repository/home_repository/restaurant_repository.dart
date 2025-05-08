import 'dart:convert';

import 'package:campuscravings/src/models/near_by_restaurant_model.dart';
import 'package:logger/logger.dart';

import '../../models/restaurant_details_model.dart';
import '../../services/http_api_services.dart';

class RestaurantRepository {
  final HttpAPIServices _httpApiServices;
  RestaurantRepository(this._httpApiServices);

  Future<List<NearByRestaurantModel>?> getNearByRestaurants({
    required double lat,
    required double lng,
  }) async {
    try {
      final response = await _httpApiServices.getAPI(
        '/restaurants/getNearbyRestaurants?latitude=33.5678&longitude=73.1234',
      );
      if (response.statusCode != 200) return null;
      return (jsonDecode(response.body)['items'] as List)
          .map((e) => NearByRestaurantModel.fromJson(e))
          .toList();
    } catch (e) {
      Logger().e('Error in getRestaurants: $e');
    }
    return null;
  }

  Future<RestaurantDetailsModel?> getRestaurantAllCategories({
    required String restaurantId,
  }) async {
    try {
      final response = await _httpApiServices.getAPI(
        '/restaurants/getrestaurantAllCategory/$restaurantId',
      );
      print("lolo popo 123 $restaurantId");
      Logger().i("${response.statusCode} - ${response.body}");
      if (response.statusCode != 200) return null;
      return RestaurantDetailsModel.fromJson(
        jsonDecode(response.body)['RestaurantData'],
      );
    } catch (e) {
      Logger().e('Error in getRestaurants: $e');
    }
    return null;
  }
}
