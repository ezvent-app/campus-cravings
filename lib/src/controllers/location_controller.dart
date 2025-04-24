import 'package:campuscravings/src/services/location_service.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:logger/logger.dart';

class LocationController extends GetxController{

  LocationData? _locationData;
  final LocationService _locationService;
  bool _isOperationInProgress = false;
  bool get isOperationInProgress => _isOperationInProgress;
  LocationController(this._locationService);

  Future<LocationData?> getCurrentLocation() async{
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