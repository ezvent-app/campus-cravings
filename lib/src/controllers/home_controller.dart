import 'package:campuscravings/src/constants/get_builder_id_constants.dart';
import 'package:campuscravings/src/models/popular_item_model.dart';
import 'package:campuscravings/src/repository/home_repository/home_repository.dart';
import 'package:campuscravings/src/services/location_service.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class HomeController extends GetxController{
  final LocationService _locationService;
  final HomeRepository _homeRepository;

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  List<PopularItem> _listOfPopularItems = [];
  List<PopularItem> get listOfPopularItems => _listOfPopularItems;
  HomeController(this._locationService,this._homeRepository);

  Future<void> getPopularItems() async{
    try{
      _isLoading = true;
      update([popularItemBuilderId]);
      final location = await _locationService.getCurrentLocation();
      if(location == null) return;
      _listOfPopularItems = (await _homeRepository.getPopularItems(lat: location.latitude!, lng: location.longitude!)) ?? [];
      _isLoading = false;
      update([popularItemBuilderId]);
      return;
      // Logger().i(data!.length);
    }catch(e){
      Logger().i(e);
      _isLoading = false;
      update([popularItemBuilderId]);
      return null;
    }
  }
}
