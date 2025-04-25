import 'dart:convert';

import 'package:campuscravings/src/constants/constants.dart';
import 'package:campuscravings/src/exceptions/either.dart';
import 'package:campuscravings/src/models/product_item_detail_model.dart';
import 'package:campuscravings/src/models/product_item_model.dart';
import 'package:campuscravings/src/services/logger_service.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import '../../services/http_api_services.dart';

class ProductRepository{

  final HttpAPIServices _httpApiServices;
  ProductRepository(this._httpApiServices);

  Future<List<ProductItem>?> getPopularItems({required double lat,required double lng}) async{
    try{
      final response = await _httpApiServices.getAPI('/restaurants/getNearbyPopularFood?latitude=24.5113&longitude=67.6221');
      Logger().i('${response.statusCode} - ${response.body}');

       if(response.statusCode != 200) return null;
      return (jsonDecode(response.body)['items'] as List)
          .map((e) => ProductItem.fromJson(e))
          .toList();
    }catch(e){
      Logger().e('Error in getPopularItems: $e');
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