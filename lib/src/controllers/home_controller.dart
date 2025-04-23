import 'package:campuscravings/src/repository/home_repository/home_repository.dart';
import 'package:campuscravings/src/services/http_api_services.dart';
import 'package:campuscravings/src/services/location_service.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class HomeController extends GetxController{

  final LocationService _locationService;
  final HomeRepository _homeRepository;
  HomeController(this._locationService,this._homeRepository);

  Future getPopularItems() async{
    try{
      final location = await _locationService.getCurrentLocation();
      if(location == null) return;
      Logger().i(location.latitude);
      final data = await _homeRepository.getPopularItems(lat: location.latitude!, lng: location.longitude!);
      Logger().i(data);
      // Logger().i(data!.length);
    }catch(e){
      Logger().i(e);
      return null;
    }
  }
}
