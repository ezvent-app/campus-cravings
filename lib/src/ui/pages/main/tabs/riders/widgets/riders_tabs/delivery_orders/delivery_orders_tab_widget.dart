import 'dart:async';
import 'dart:developer' as dev;
import 'dart:math';

import 'package:campuscravings/src/constants/storageHelper.dart';
import 'package:campuscravings/src/models/Rider_delivery_model/Rider_delivery_model.dart';
import 'package:campuscravings/src/models/delivery_order_model.dart';
import 'package:campuscravings/src/providers/delivery_order_provider.dart';
import 'package:campuscravings/src/repository/rider_delivery_repo/rider_delivery_repo.dart';
import 'package:campuscravings/src/src.dart';
import 'package:custom_marker_builder/custom_marker_builder.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

class DeliveryOrdersTabWidget extends ConsumerStatefulWidget {
  const DeliveryOrdersTabWidget({super.key});

  @override
  ConsumerState<DeliveryOrdersTabWidget> createState() =>
      _ConsumerDeliveryOrdersTabWidgetState();
}

class _ConsumerDeliveryOrdersTabWidgetState
    extends ConsumerState<DeliveryOrdersTabWidget> {
  bool _isLoading = false;
  bool _isAccepting = false;
  final isRiderTabActiveProvider = StateProvider<bool>((ref) => false);

  late Timer timer;
  Timer? _orderCycleTimer;
  bool _isMounted = true;
  bool _hasShownBottomSheet = false;
  List<DeliveryOrder> _remainingOrders = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref.read(isRiderTabActiveProvider.notifier).state = true;
      }
      _setupSocket();
    });
    startTimer();
    _startLocationStream();
  }

  void _setupSocket() async {
    if (!_isMounted) return;

    final socketController = ref.read(socketControllerProvider);

    if (ref.read(socketStateProvider).status != SocketStatus.connected) {
      final token = StorageHelper().getAccessToken();
      if (token == null) return;
      socketController.connect(token);
    }

    if (_isMounted) {
      socketController.listenForOrders((dynamic data) {
        print("Orders Data: $data");
        ref.read(socketDeliveryControllerProvider).handleSocketData(data);
      });
    }
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      final countdown = ref.read(riderProvider)['countdown'];
      if (countdown > 0) {
        ref.read(riderProvider.notifier).state = {
          ...ref.read(riderProvider),
          'countdown': countdown - 1,
        };
      } else {
        timer.cancel();
      }
    });
  }

  void _cycleOrders(List<DeliveryOrder> orders) {
    if (!_isMounted || orders.isEmpty) {
      _orderCycleTimer?.cancel();
      return;
    }

    // Initialize remaining orders if not already set
    if (_remainingOrders.isEmpty) {
      _remainingOrders = List.from(orders);
    }

    if (_remainingOrders.isEmpty) {
      _orderCycleTimer?.cancel();
      return;
    }

    // Close any existing bottom sheet before showing the new one
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }

    // Reset countdown for the new order
    ref.read(riderProvider.notifier).state = {
      ...ref.read(riderProvider),
      'countdown': 10,
    };

    // Restart the countdown timer
    timer.cancel();
    startTimer();

    // Show the current order
    confirmDeliveryBottomSheet(_remainingOrders[0]);

    _orderCycleTimer?.cancel();
    _orderCycleTimer = Timer(Duration(seconds: 10), () {
      if (!_isMounted) {
        return;
      }

      setState(() {
        // Remove the displayed order from the list
        if (_remainingOrders.isNotEmpty) _remainingOrders.removeAt(0);
      });

      // Continue cycling if there are more orders
      if (_remainingOrders.isNotEmpty) {
        _cycleOrders(_remainingOrders);
      } else {
        // Close the bottom sheet if no orders remain
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      }
    });
  }

  @override
  void dispose() {
    if (mounted) {
      ref.read(isRiderTabActiveProvider.notifier).state = false;
    }
    timer.cancel();
    _orderCycleTimer?.cancel();
    _locationUpdateTimer?.cancel();
    _positionStreamSubscription?.cancel();
    _isMounted = false;
    super.dispose();
  }

  late GoogleMapController mapController;
  Map<String, Marker> markers = {};

  Set<Polyline> polylines = {};

  LatLng riderLocation = LatLng(40.730610, -73.935242);

  Timer? _locationUpdateTimer;
  final RiderLocationRepo _riderLocationRepo = RiderLocationRepo();

  StreamSubscription<Position>? _positionStreamSubscription;

  // final customerLatLng = StorageHelper().getCustomerCoords();

  void _startLocationStream() {
    final locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );

    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen((Position position) async {
      final LatLng newLatLng = LatLng(position.latitude, position.longitude);

      setState(() {
        riderLocation = newLatLng;
      });

      await sendLocationToBackend(newLatLng);
      updateMarkerPosition('rider', newLatLng);
    });
  }

  Future<void> sendLocationToBackend(LatLng latLng) async {
    try {
      await _riderLocationRepo.sendLocation({
        'latitude': latLng.latitude,
        'longitude': latLng.longitude,
      });
      debugPrint('Location sent to server');
    } catch (e) {
      debugPrint('Failed to send location: $e');
    }
  }

  double _getBearingBetweenTwoPoints(LatLng start, LatLng end) {
    double lat1 = start.latitude * pi / 180;
    double lon1 = start.longitude * pi / 180;
    double lat2 = end.latitude * pi / 180;
    double lon2 = end.longitude * pi / 180;

    double dLon = lon2 - lon1;
    double y = sin(dLon) * cos(lat2);
    double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
    double bearing = atan2(y, x);
    return (bearing * 180 / pi + 360) % 360;
  }

  LatLng? _lastRiderLocation;
  LatLng? _lastCustomerLocation;

  void updateMarkerPosition(String id, LatLng newLatLng) {
    final oldLatLng =
        id == 'rider'
            ? _lastRiderLocation ?? riderLocation
            : _lastCustomerLocation;
    if (id == 'rider') _lastRiderLocation = newLatLng;
    if (id == 'customer') _lastCustomerLocation = newLatLng;

    final marker = markers[id];
    if (marker == null) return;

    final updatedMarker = marker.copyWith(
      positionParam: newLatLng,
      rotationParam: _getBearingBetweenTwoPoints(oldLatLng!, newLatLng),
    );

    setState(() {
      markers[id] = updatedMarker;
    });

    if (id == 'rider') {
      mapController.animateCamera(CameraUpdate.newLatLng(newLatLng));
    }
  }

  Future<void> _initializeMap(LatLng? customerLocation) async {
    try {
      setState(() {
        markers.clear();
        polylines.clear();
      });

      final riderIcon = await CustomMapMarkerBuilder.fromWidget(
        context: context,
        marker: RiderMarkerWidget(),
      );

      setState(() {
        markers['rider'] = Marker(
          markerId: MarkerId('rider'),
          position: riderLocation,
          icon: riderIcon,
          infoWindow: InfoWindow(title: 'Rider'),
        );
      });

      if (customerLocation != null) {
        final customerIcon = await CustomMapMarkerBuilder.fromWidget(
          context: context,
          marker: CustomerMarkerWidget(),
        );

        setState(() {
          markers['customer'] = Marker(
            markerId: MarkerId('customer'),
            position: customerLocation,
            icon: customerIcon,
            infoWindow: InfoWindow(title: 'Customer'),
          );
        });

        await _getRouteBetweenPoints(customerLocation);

        // Zoom to fit both locations
        final bounds = LatLngBounds(
          southwest: LatLng(
            min(riderLocation.latitude, customerLocation.latitude),
            min(riderLocation.longitude, customerLocation.longitude),
          ),
          northeast: LatLng(
            max(riderLocation.latitude, customerLocation.latitude),
            max(riderLocation.longitude, customerLocation.longitude),
          ),
        );
        mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 20));
      } else {
        mapController.animateCamera(
          CameraUpdate.newLatLngZoom(riderLocation, 10),
        );
      }
    } catch (e) {
      print('Error initializing map: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Map error: ${e.toString()}')));
    }
  }

  Future<void> _getRouteBetweenPoints(LatLng customerLocation) async {
    try {
      PolylinePoints polylinePoints = PolylinePoints();

      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey: apiKey,
        request: PolylineRequest(
          origin: PointLatLng(riderLocation.latitude, riderLocation.longitude),
          destination: PointLatLng(
            customerLocation.latitude,
            customerLocation.longitude,
          ),
          mode: TravelMode.driving,
        ),
      );

      if (result.points.isEmpty) {
        throw Exception('No route points returned: ${result.errorMessage}');
      }

      List<LatLng> polylineCoordinates =
          result.points
              .map((point) => LatLng(point.latitude, point.longitude))
              .toList();

      setState(() {
        polylines.add(
          Polyline(
            polylineId: PolylineId('route'),
            points: polylineCoordinates,
            color: Colors.red,
            width: 5,
            startCap: Cap.roundCap,
            endCap: Cap.roundCap,
          ),
        );
      });
    } catch (e) {
      dev.log('Error getting route: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not load route: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final wdth = size.width;
    final height = size.height;

    double topPosition = height * 0.44;
    double leftPosition = wdth * 0.85;
    double buttonWidth = wdth * 0.8;

    ref.listen(deliveryOrdersProvider, (previous, next) {
      final isTabActive = ref.read(isRiderTabActiveProvider);
      if (isTabActive && next.isNotEmpty && !_hasShownBottomSheet) {
        _hasShownBottomSheet = true;
        _remainingOrders = List.from(next);
        _cycleOrders(next);
      } else if (next.isEmpty) {
        _orderCycleTimer?.cancel();
        _hasShownBottomSheet = false;
        _remainingOrders.clear();
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      }
    });

    final riderDeliveryPro = ref.watch(riderDeliveryProvider);

    return Consumer(
      builder: (context, ref, child) {
        final isAccept = ref.watch(riderProvider);
        return Stack(
          children: [
            Positioned.fill(
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: riderLocation,
                  zoom: 12.0,
                ),
                markers: markers.values.toSet(),
                polylines: polylines,

                indoorViewEnabled: true,
                zoomControlsEnabled: false,
                trafficEnabled: true,
                onMapCreated: (controller) {
                  mapController = controller;
                  WidgetsBinding.instance.addPostFrameCallback((_) async {
                    await Future.delayed(Duration(seconds: 1));
                    await _initializeMap(null);
                  });
                },
                myLocationEnabled: false,
                myLocationButtonEnabled: false,
              ),
            ),
            Positioned(
              bottom: Platform.isIOS ? 30 : 20,
              right: Platform.isIOS ? 20 : 16,
              child: FloatingActionButton(
                backgroundColor:
                    Platform.isIOS ? Colors.grey[200] : Colors.white,
                elevation: Platform.isIOS ? 1 : 4,
                onPressed: () {
                  mapController.animateCamera(
                    CameraUpdate.newLatLng(riderLocation),
                  );
                },
                child: Icon(
                  Icons.my_location,
                  color: Platform.isIOS ? Colors.black : Colors.blue,
                ),
              ),
            ),

            isAccept["isAccept"]
                ? Positioned(
                  top: topPosition,
                  left: leftPosition - buttonWidth / 2,
                  child: GestureDetector(
                    onTap: () {
                      mapController.animateCamera(
                        CameraUpdate.newLatLng(riderLocation),
                      );
                    },
                    child: Card(
                      color: AppColors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: EdgeInsets.all(10),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          children: [
                            SvgAssets("rider_dir", width: 28, height: 28),
                            width(10),
                            Text(
                              "Navigation",
                              style: Theme.of(context).textTheme.titleSmall!
                                  .copyWith(color: AppColors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                : SizedBox(),
            isAccept["isAccept"]
                ? GestureDetector(
                  child: AnimatedRidersDeliveryDetailsWrapper(
                    riderDelivery: riderDeliveryPro,
                  ),
                )
                : SizedBox(),
          ],
        );
      },
    );
  }

  void confirmDeliveryBottomSheet(DeliveryOrder order) {
    print("Order: ${order.id}");

    StorageHelper().saveRiderOrderId(order.id);
    final size = MediaQuery.of(context).size;

    showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStateDialog) {
            return SizedBox(
              height: 350,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              '\$${order.price.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            width(10),
                            Text(
                              order.guaranteedLabel,
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(color: AppColors.black),
                            ),
                          ],
                        ),
                        Consumer(
                          builder: (context, ref, child) {
                            final countdown =
                                ref.watch(riderProvider)['countdown'];
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: CircularProgressIndicator(
                                    value: countdown / 10,
                                    strokeWidth: 10,
                                    backgroundColor: Colors.grey.shade300,
                                    color: AppColors.accent,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                    Text(
                      '${order.distance} mi',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(color: AppColors.black),
                    ),
                    Text(
                      order.deliveryTime,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(color: AppColors.black),
                    ),
                    Divider(color: AppColors.dividerColor),
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Card(
                                  margin: EdgeInsets.zero,
                                  color: AppColors.buttonGradient1,
                                  shape: StadiumBorder(),
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                  ),
                                ),
                                height(5),
                                _buildDottedLine(),
                                height(5),
                                Icon(
                                  Icons.location_pin,
                                  color: Colors.red,
                                  size: 30,
                                ),
                              ],
                            ),
                            width(10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Pickup',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: AppColors.black),
                                  ),
                                  Text(
                                    order.pickupItem,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  height(48),
                                  Text(
                                    order.dropoffLabel,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: AppColors.black),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(color: AppColors.dividerColor),
                    height(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: size.width * .4,
                          child: Consumer(
                            builder: (context, ref, child) {
                              return RoundedButtonWidget(
                                isLoading: _isAccepting,
                                btnTitle: "Accept",
                                onTap: () async {
                                  setStateDialog(() {
                                    _isLoading = true;
                                  });

                                  timer.cancel(); // pause timer

                                  final isAccept = ref.read(riderProvider);
                                  ref.read(riderProvider.notifier).state = {
                                    ...isAccept,
                                    'isAccept': true,
                                  };

                                  final body = {
                                    "estimated_time":
                                        order.deliveryDurationInMinutes,
                                    "orderId": order.id,
                                  };

                                  try {
                                    final riderDeliveryResponse = await ref
                                        .read(
                                          acceptedByRiderProvider(body).future,
                                        );

                                    if (riderDeliveryResponse == null) {
                                      Logger().e("Failed to accept the order.");
                                      return;
                                    }

                                    final customerCoords =
                                        riderDeliveryResponse
                                            .order
                                            ?.addresses
                                            ?.coordinates
                                            ?.coordinates;

                                    if (customerCoords == null ||
                                        customerCoords.length < 2) {
                                      Logger().e(
                                        "Invalid customer coordinates",
                                      );
                                      return;
                                    }

                                    setState(() {
                                      _remainingOrders.clear();
                                    });

                                    final newCustomerLocation = LatLng(
                                      customerCoords[0],
                                      customerCoords[1],
                                    );

                                    await _initializeMap(newCustomerLocation);

                                    ref
                                        .read(riderDeliveryProvider.notifier)
                                        .state = riderDeliveryResponse;

                                    _orderCycleTimer?.cancel();

                                    Navigator.pop(context);
                                  } catch (e) {
                                    Logger().e("Error accepting order: $e");
                                  } finally {
                                    setStateDialog(() {
                                      _isLoading = false;
                                    });
                                  }
                                },
                              );
                            },
                          ),
                        ),

                        width(10),
                        SizedBox(
                          width: size.width * .4,
                          child: OutlinedButton(
                            onPressed: () {
                              final isAccept = ref.read(riderProvider);

                              ref.read(riderProvider.notifier).state = {
                                ...isAccept,
                                'isAccept': false,
                              };
                              Navigator.pop(context);
                              // Remove the current order from remaining orders
                              setState(() {
                                _remainingOrders.removeAt(0);
                              });
                              // Continue cycling if there are more orders
                              if (_remainingOrders.isNotEmpty) {
                                _cycleOrders(_remainingOrders);
                              }
                            },
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              side: BorderSide(color: Colors.black),
                              padding: EdgeInsets.symmetric(vertical: 11),
                            ),
                            child: Text(
                              'Decline',
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium!.copyWith(
                                color: AppColors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDottedLine() {
    return Column(
      children: List.generate(
        5,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Container(
            width: 3,
            height: 3,
            decoration: BoxDecoration(color: AppColors.black),
          ),
        ),
      ),
    );
  }
}

final riderProvider = StateProvider<Map<String, dynamic>>(
  (ref) => {'isAccept': false, 'countdown': 10},
);

final riderDeliveryProvider = StateProvider<RiderDeliveryModel?>((ref) => null);

final isDeliveryStartedProvider = StateProvider<bool>((ref) => false);
