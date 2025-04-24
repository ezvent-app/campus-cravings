import 'dart:convert';

import 'package:campuscravings/src/constants/constants.dart';
import 'package:campuscravings/src/exceptions/either.dart';
import 'package:campuscravings/src/models/product_item_model.dart';
import 'package:campuscravings/src/models/restaurant_model.dart';
import 'package:campuscravings/src/services/logger_service.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import '../../services/http_api_services.dart';

class RestaurantRepository{

  final HttpAPIServices _httpApiServices;
  RestaurantRepository(this._httpApiServices);

  Future<List<RestaurantModel>?> getNearByRestaurants({required double lat,required double lng}) async{
    try{
      final response = await _httpApiServices.getAPI('/restaurants/getNearbyRestaurants?latitude=24.5113&longitude=67.6221');
      if(response.statusCode != 200) return null;
      return (jsonDecode(response.body)['items'] as List)
          .map((e) => RestaurantModel.fromJson(e))
          .toList();
    }catch(e){
      Logger().e('Error in getRestaurants: $e');
    }
    return null;
  }

}