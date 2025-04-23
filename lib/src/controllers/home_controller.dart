import 'package:campuscravings/src/repository/home_repository/home_repository.dart';
import 'package:campuscravings/src/services/http_api_services.dart';
import 'package:campuscravings/src/services/location_service.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class HomeController extends GetxController{

  final LocationService _locationHandlerService;
  final HomeRepository _homeRepository;
  HomeController(this._locationHandlerService,this._homeRepository);

  Future getPopularItems() async{
    try{
      final data = await _homeRepository.getPopularItems();
    }catch(e){
      Logger().i(e);
      return null;
    }
  }
}
