import 'dart:convert';

import 'package:campuscravings/src/exceptions/either.dart';
import 'package:campuscravings/src/models/popular_item_model.dart';
import 'package:campuscravings/src/services/logger_service.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import '../../services/http_api_services.dart';

class HomeRepository{
  final HttpApiServices _httpApiServices;
  HomeRepository(this._httpApiServices);
  final _logger = LoggerService();
  Future<List<PopularItem>?> getPopularItems({required double lat,required double lng}) async{
    try{
      final response = await _httpApiServices.getAPI('/restaurants/getNearbyPopularFood?latitude=24.5113&longitude=67.6221');
      Logger().i('${response.statusCode} - ${response.body}');

       if(response.statusCode != 200) return null;
      return (jsonDecode(response.body)['items'] as List)
          .map((e) => PopularItem.fromJson(e))
          .toList();
       final data = PopularItem.fromJson(jsonDecode(response.body)['items'][0]);
      _logger.log(data);
    }catch(e){
      _logger.log(e);
    }
    return null;
  }
}