import 'dart:convert';

import 'package:campuscravings/src/models/product_item_detail_model.dart';
import 'package:campuscravings/src/models/product_item_model.dart';
import 'package:logger/logger.dart';

import '../../services/http_api_services.dart';

class ProductRepository {
  final HttpAPIServices _httpApiServices;
  ProductRepository(this._httpApiServices);

  Future<List<ProductItemModel>?> getPopularItems({
    required double lat,
    required double lng,
  }) async {
    try {
      final response = await _httpApiServices.getAPI(
        '/restaurants/getNearbyPopularFood?latitude=33.5678&longitude=73.1234',
      );
      Logger().i(jsonDecode(response.body));

      if (response.statusCode != 200) return null;
      return (jsonDecode(response.body)['items'] as List)
          .map((e) => ProductItemModel.fromJson(e))
          .toList();
    } catch (e) {
      Logger().e('Error in getPopularItems: $e');
    }
    return null;
  }

  Future<ProductItemDetailModel?> getProductItemDetails({
    required String itemId,
  }) async {
    try {
      final response = await _httpApiServices.getAPI(
        '/categories/getitem/$itemId',
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
