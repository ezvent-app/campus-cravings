import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final locationProvider = AsyncNotifierProvider<LocationNotifier, LocationModel>(
  () => LocationNotifier(),
);

class LocationNotifier extends AsyncNotifier<LocationModel> {
  @override
  Future<LocationModel> build() async {
    return await _getCurrentLocation();
  }

  /// Fetch current location and address
  Future<LocationModel> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    Position position = await Geolocator.getCurrentPosition();
    final latLng = LatLng(position.latitude, position.longitude);

    final address = await _getAddressFromLatLng(latLng);

    return LocationModel(latLng, address);
  }

  /// Refresh current location and address
  Future<void> refreshLocation() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async => await _getCurrentLocation());
  }

  /// Update manually when map moves
  Future<void> updateLocation(LatLng latLng) async {
    state = const AsyncLoading();
    final address = await _getAddressFromLatLng(latLng);
    state = AsyncValue.data(LocationModel(latLng, address));
  }

  /// Reverse geocode
  Future<String?> _getAddressFromLatLng(LatLng latLng) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );
      final place = placemarks.first;
      return "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
    } catch (e) {
      return null;
    }
  }
}

class LocationModel {
  final LatLng latLng;
  final String? address;

  LocationModel(this.latLng, this.address);
}
