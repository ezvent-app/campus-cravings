import 'package:campuscravings/src/services/http_api_services.dart';
import 'package:campuscravings/src/services/location_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  final LocationService _locationHandlerService;
  final HttpApiServices _httpApiServices;
  HomeController(this._locationHandlerService,this._httpApiServices);

  Future getPopularItems() async{

    try{
      final response = await _httpApiServices.getAPI('restaurants/getNearbyPopularFood?latitude=24.5113&longitude=67.6221');

    }catch(e){
      return null;
    }
  }
}
