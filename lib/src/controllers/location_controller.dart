import 'package:campuscravings/src/services/location_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class LocationController extends GetxController{

  Position? _locationData;
  Position? get locationData => _locationData;
  final LocationService _locationService;
  bool _isOperationInProgress = false;
  bool get isOperationInProgress => _isOperationInProgress;
  LocationController(this._locationService);

  Future<Position?> getCurrentLocation() async{
    try {
      if (_locationData != null) return _locationData;
      _isOperationInProgress = true;
      _locationData = await _locationService.getCurrentLocation();
      _isOperationInProgress = false;
      return _locationData;
    }catch(e){
      Logger().i(e);
      _isOperationInProgress = false;
      return null;
    }
  }
}