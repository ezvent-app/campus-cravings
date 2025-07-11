import 'dart:convert';
import 'package:campuscravings/src/models/User%20Model/nearby_restaurants_model.dart';
import 'package:campuscravings/src/models/catagory_viewing_model.dart';
import 'package:campuscravings/src/models/product_item_detail_model.dart';
import 'package:campuscravings/src/models/search_model.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import '../../services/http_api_services.dart';

class SearchRepository {
  final HttpAPIServices _httpApiServices;
  SearchRepository(this._httpApiServices);

  Future<SearchModel?> searchFoodOrRestaurants({
    required String search,
    required double lat,
    required double lng,
  }) async {
    try {
      final response = await _httpApiServices.getAPI(
        '/restaurants/search?latitude=$lat&longitude=$lng&search=$search',
      );

      if (response.statusCode != 200) return null;
      final jsonList = jsonDecode(response.body)['searchResult'];
      Logger().w(jsonList);
      return SearchModel.fromJson(jsonDecode(response.body)['searchResult']);
    } catch (e) {
      Logger().e('Error in Search food and restaurant api: $e');
    }
    return null;
  }

  Future<CategoryViewingModel?> displayCategoriesName({
    required double lat,
    required double lng,
  }) async {
    try {
      // final lat = 21802810;
      // final lng = 77202810;
      final response = await _httpApiServices.getAPI(
        '/categories/getcategoryname?latitude=$lat&longitude=$lng',
      );

      if (response.statusCode != 200) return null;
      final jsonList = jsonDecode(response.body);
      Logger().w(jsonList);
      return CategoryViewingModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      Logger().e('Error in Displaying Categories: $e');
    }
    return null;
  }

  Future<NearbyRestaurantsResponse?> searchCategory({
    required String search,
    required double lat,
    required double lng,
  }) async {
    try {
      final response = await _httpApiServices.getAPI(
        '/restaurants/searchCategory?latitude=$lat&longitude=$lng&search=$search',
      );

      if (response.statusCode != 200) return null;

      return NearbyRestaurantsResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      Logger().e('Error in category api: $e');
    }
    return null;
  }

  Future<ProductItemDetailModel?> getProductItemDetails({
    required String itemId,
  }) async {
    try {
      final response = await _httpApiServices.getAPI(
        '/categories/getitem/680a4315daf93d11efe3fc4d',
      );
      Logger().i('${response.statusCode} - ${response.body}');
      if (response.statusCode != 200) return null;
      return ProductItemDetailModel.fromJson(
        jsonDecode(response.body)['items'],
      );
    } catch (e) {
      Logger().e('Error in getProductItemDetails: $e');
    }
    return null;
  }
}
