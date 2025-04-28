import 'dart:convert';

import 'package:campuscravings/src/constants/constants.dart';
import 'package:campuscravings/src/exceptions/either.dart';
import 'package:campuscravings/src/models/near_by_restaurant_model.dart';
import 'package:campuscravings/src/models/product_item_detail_model.dart';
import 'package:campuscravings/src/models/product_item_model.dart';
import 'package:campuscravings/src/models/search_model.dart';
import 'package:campuscravings/src/services/logger_service.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import '../../services/http_api_services.dart';

class SearchRepository{

  final HttpAPIServices _httpApiServices;
  SearchRepository(this._httpApiServices);

  Future<SearchModel?> searchFoodOrRestaurants({required String search,required double lat, required double lng}) async{
    try{
      final response = await _httpApiServices.getAPI('/restaurants/search?latitude=33.5678&longitude=73.1234&search=$search');

      if(response.statusCode != 200) return null;
      final jsonList = jsonDecode(response.body)['searchResult'];
      Logger().w(jsonList);
      return SearchModel.fromJson(jsonDecode(response.body)['searchResult']);
    }catch(e){
      Logger().e('Error in Search food and restaurant api: $e');
    }
    return null;
  }

  Future<ProductItemDetailModel?> getProductItemDetails({required String itemId}) async{
    try{
      final response = await _httpApiServices.getAPI('/categories/getitem/680a4315daf93d11efe3fc4d');
      Logger().i('${response.statusCode} - ${response.body}');
      if(response.statusCode != 200) return null;
      return ProductItemDetailModel.fromJson(jsonDecode(response.body)['items']);
    }catch(e){
      Logger().e('Error in getProductItemDetails: $e');
    }
    return null;
  }
}