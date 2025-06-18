import 'dart:developer';

import 'package:campuscravings/src/models/User%20Model/user_info_model.dart';
import 'package:campuscravings/src/src.dart';
import 'package:custom_marker_builder/custom_marker_builder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

final locationProvider = AsyncNotifierProvider<LocationNotifier, LocationModel>(
  () => LocationNotifier(),
);
final addressSavingProvider = StateProvider<bool>((ref) => false);

class LocationNotifier extends AsyncNotifier<LocationModel> {
  final HttpAPIServices services = HttpAPIServices();

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

    return LocationModel(latLng: latLng, address: address);
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
    state = AsyncValue.data(LocationModel(latLng: latLng, address: address));
  }

  /// Reverse geocode
  Future<String?> _getAddressFromLatLng(LatLng latLng) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );
      final place = placemarks.first;
      return "${place.street}, ${place.subAdministrativeArea}, ${place.country}";
    } catch (e) {
      return null;
    }
  }

  void defaultAddressMethod(bool value) {
    final current = state.value;
    if (current != null) {
      state = AsyncValue.data(current.copyWith(isDefault: value));
    }
  }

  Future<void> saveAddress(BuildContext context) async {
    try {
      final loading = ref.read(addressSavingProvider.notifier);
      loading.state = true;

      final current = state.value!;
      final address = {
        'address': current.locationController.text,
        "coordinates": {
          "type": "Point",
          "coordinates": [current.latLng.latitude, current.latLng.longitude],
        },
      };

      final res = await services.patchAPI(
        map: address,
        url: "/user/addAddress/",
      );

      final body = jsonDecode(res.body);
      if (res.statusCode == 200) {
        if (context.mounted) {
          showToast(body['message'], context: context);
          Navigator.pop(context, true);
        }
      } else {
        if (context.mounted) {
          showToast(body['message'], context: context);
        }
      }

      printThis('Saved JSON: $address');
    } catch (e) {
      printThis(e.toString());
    } finally {
      ref.read(addressSavingProvider.notifier).state = false;
    }
  }

  Future<void> deleteAddress({
    required BuildContext context,
    required String addressId,
  }) async {
    try {
      final loading = ref.read(addressSavingProvider.notifier);
      loading.state = true;

      final res = await services.deleteAPI("/user/deleteAddress/$addressId");

      final body = jsonDecode(res.body);

      if (res.statusCode == 200) {
        if (context.mounted) {
          showToast(body['message'], context: context);
        }
      } else {
        if (context.mounted) {
          showToast(body['message'], context: context);
        }
      }
    } catch (e) {
      printThis('Error deleting address: $e');
    } finally {
      ref.read(addressSavingProvider.notifier).state = false;
    }
  }

  Future<void> selectedAddress(
    BuildContext context,
    OrderAddress address,
    int index,
  ) async {
    try {
      final current = state.value;
      if (current != null) {
        log("ADDRESS ${address.address}");
        state = AsyncValue.data(
          current.copyWith(addresses: address, selectedIndex: index),
        );
      }
    } catch (e) {
      printThis(e.toString());
    }
  }

  Future<void> setupMarkersAndPolylines({
    required BuildContext context,
    required LatLng ryderLocation,
    required Widget markerWidget,
  }) async {
    try {
      final bitmap = await CustomMapMarkerBuilder.fromWidget(
        context: context,
        marker: markerWidget,
      );

      final current = state.value;
      if (current == null) return;

      final customerLocation = current.latLng;

      final markers = {
        Marker(
          markerId: const MarkerId('ryder'),
          infoWindow: const InfoWindow(title: 'Ryder Location'),
          position: ryderLocation,
          icon: bitmap,
        ),
      };

      final polylines = {
        Polyline(
          polylineId: const PolylineId('line_between'),
          visible: true,
          points: [ryderLocation, customerLocation],
          color: AppColors.accent,
          width: 5,
        ),
      };

      state = AsyncValue.data(
        current.copyWith(markers: markers, polylines: polylines),
      );
    } catch (e) {
      printThis('Error setting up markers/polylines: $e');
    }
  }
}

class LocationModel {
  final LatLng latLng;
  final String? address;
  final Set<Marker> markers;
  final Set<Polyline> polylines;
  final TextEditingController locationController;
  final TextEditingController floorController;
  final TextEditingController roomNoController;
  final TextEditingController saveAsController;
  final bool isDefault;
  final OrderAddress? addresses;
  final int? selectedIndex;

  LocationModel({
    this.selectedIndex = -1,
    this.addresses,
    required this.latLng,
    required this.address,
    this.markers = const {},
    this.polylines = const {},
    TextEditingController? locationController,
    TextEditingController? floorController,
    TextEditingController? roomNoController,
    TextEditingController? saveAsController,
    bool? isDefault,
  }) : locationController =
           locationController ?? TextEditingController(text: address),
       floorController = floorController ?? TextEditingController(),
       roomNoController = roomNoController ?? TextEditingController(),
       saveAsController = saveAsController ?? TextEditingController(),
       isDefault = isDefault ?? true;

  LocationModel copyWith({
    LatLng? latLng,
    String? address,
    Set<Marker>? markers,
    Set<Polyline>? polylines,
    TextEditingController? locationController,
    TextEditingController? floorController,
    TextEditingController? roomNoController,
    TextEditingController? saveAsController,
    bool? isDefault,
    OrderAddress? addresses,
    int? selectedIndex,
  }) {
    return LocationModel(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      addresses: addresses ?? this.addresses,
      latLng: latLng ?? this.latLng,
      address: address ?? this.address,
      markers: markers ?? this.markers,
      polylines: polylines ?? this.polylines,
      locationController: locationController ?? this.locationController,
      floorController: floorController ?? this.floorController,
      roomNoController: roomNoController ?? this.roomNoController,
      saveAsController: saveAsController ?? this.saveAsController,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}

class OrderAddress {
  Coordinates? coordinates;
  String? address;

  OrderAddress({this.coordinates, this.address});

  OrderAddress.fromJson(Map<String, dynamic> json) {
    coordinates =
        json['coordinates'] != null
            ? Coordinates.fromJson(json['coordinates'])
            : null;
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (coordinates != null) {
      data['coordinates'] = coordinates!.toJson();
    }
    data['address'] = address;
    return data;
  }
}
