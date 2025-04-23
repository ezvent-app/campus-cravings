import 'package:campuscravings/src/exceptions/either.dart';
import 'package:campuscravings/src/models/popular_item_model.dart';
import 'package:campuscravings/src/services/logger_service.dart';

import '../../services/http_api_services.dart';

class HomeRepository{
  final HttpApiServices _httpApiServices;
  HomeRepository(this._httpApiServices);
  final _logger = LoggerService();
  Future<List<PopularItem>?> getPopularItems() async{
    try{
      final response = await _httpApiServices.getAPI('restaurants/getNearbyPopularFood?latitude=24.5113&longitude=67.6221');
      _logger.log(response.body);
    }catch(e){
      _logger.log(e);
    }
    return null;
  }
}