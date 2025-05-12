import 'package:geolocator/geolocator.dart' as geo;
import 'package:location/location.dart';

class LocationService {
  final _location = Location();

  Future<bool> _checkIfServiceEnabled() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }
    return true;
  }

  Future<bool> checkIfPermissionGranted() async {
    if (await _checkIfServiceEnabled() == false) return false;
    final permissionStatus = await _location.hasPermission();
    if (permissionStatus == PermissionStatus.granted) {
      return true;
    } else if (permissionStatus == PermissionStatus.denied) {
      final permissionStatus = await _location.requestPermission();
      if (permissionStatus == PermissionStatus.granted) return true;
    }
    return false;
  }

  Future<geo.Position?> getCurrentLocation() async {
    if (await checkIfPermissionGranted() == false) return null;
    return await geo.Geolocator.getCurrentPosition(
      locationSettings: geo.LocationSettings(
        accuracy: geo.LocationAccuracy.high,
        timeLimit: Duration(seconds: 5),
      ),
    );
  }
}
