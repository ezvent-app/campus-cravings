import 'dart:convert';
import 'dart:developer';

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
        '/restaurants/getNearbyPopularFood?latitude=$lat&longitude=$lng',
      );

      Logger().i('📥 PopularItems Response: ${response.body}');

      if (response.statusCode != 200) return null;

      final decoded = jsonDecode(response.body);

      final items = decoded['items'];

      if (items is List) {
        return items
            .whereType<Map<String, dynamic>>()
            .map((item) => ProductItemModel.fromJson(item))
            .toList();
      }

      if (items is Map<String, dynamic> && items.containsKey('message')) {
        Logger().w('⚠️ No popular items found: ${items['message']}');
        return [];
      }

      Logger().e('❌ Unexpected items structure: $items');
    } catch (e, stack) {
      Logger().e('❌ Exception in getPopularItems', error: e, stackTrace: stack);
    }

    return null;
  }

  Future<ProductItemDetailModel?> getProductItemDetails({
    required String itemId,
  }) async {
    try {
      log("ITEM ID $itemId");
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
