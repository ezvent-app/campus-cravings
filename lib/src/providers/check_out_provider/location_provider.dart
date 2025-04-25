import 'package:campuscravings/src/src.dart';
import 'package:custom_marker_builder/custom_marker_builder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

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
      return "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
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

  saveAddress(BuildContext context) async {
    try {
      final current = state.value!;
      final address = {
        'fullAddress':
            "${current.locationController.text}, ${current.floorController.text}, ${current.roomNoController.text}",
        'saveAs': current.saveAsController.text,
        'isDefault': current.isDefault,
      };

      final existingList = SharePreferences.getList('saved_address') ?? [];

      existingList.add(jsonEncode(address));

      await SharePreferences.setList(key: 'saved_address', value: existingList);

      printThis('Saved JSON: $address');
      if (context.mounted) {
        showToast("Address saved", context: context);
        context.maybePop();
      }
    } catch (e) {
      printThis(e.toString());
    }
  }

  Future<void> selectedAddress(
    BuildContext context,
    Map<String, dynamic> address,
  ) async {
    try {
      final newList = [jsonEncode(address)];

      await SharePreferences.setList(key: 'selectedAddress', value: newList);

      printThis('Saved JSON: $address');

      if (context.mounted) {
        context.maybePop();
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

  LocationModel({
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
  }) {
    return LocationModel(
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
