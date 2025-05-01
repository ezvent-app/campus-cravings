import 'dart:async';

import 'package:campuscravings/src/constants/storageHelper.dart';
import 'package:campuscravings/src/models/Rider_delivery_model/Rider_delivery_model.dart';
import 'package:campuscravings/src/models/delivery_order_model.dart';
import 'package:campuscravings/src/providers/delivery_order_provider.dart';
import 'package:campuscravings/src/repository/rider_delivery_repo/rider_delivery_repo.dart';
import 'package:campuscravings/src/src.dart';
import 'package:custom_marker_builder/custom_marker_builder.dart';
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
  late Timer timer;
  Timer? _orderCycleTimer;
  bool _isMounted = true;
  bool _hasShownBottomSheet = false;
  List<DeliveryOrder> _remainingOrders = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setupSocket();
    });
    startTimer();
    startSendingLocation();
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

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 10,
  );

  Future<void> animateToUserLocation(LatLng latLng) async {
    final controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(target: latLng, zoom: 10)),
    );
  }

  Timer? _locationUpdateTimer;
  final RiderLocationRepo _riderLocationRepo = RiderLocationRepo();

  LatLng riderLatLng = LatLng(33.602859, 73.0174495);

  void startSendingLocation() {
    _locationUpdateTimer = Timer.periodic(Duration(seconds: 15), (timer) async {
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
      );

      LatLng latLng = LatLng(position.latitude, position.longitude);

      await sendLocationToBackend(latLng);

      animateToUserLocation(latLng);
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

  @override
  void dispose() {
    timer.cancel();
    _orderCycleTimer?.cancel();
    _locationUpdateTimer?.cancel();
    _isMounted = false;
    super.dispose();
  }

  int currentIndex = 0;

  GoogleMapController? mapController;

  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  final LatLng _ryderLocation = const LatLng(33.642631, 72.961899);

  Future<void> _setupMarkersAndPolyline() async {
    final bitmap = await CustomMapMarkerBuilder.fromWidget(
      context: context,
      marker: RiderMarkerWidget(),
    );

    if (!_isMounted) return; // Check if widget is still mounted

    setState(() {
      _markers = {
        Marker(
          markerId: MarkerId('ryder'),
          infoWindow: const InfoWindow(title: 'Ryder Location'),
          position: riderLatLng,
          icon: bitmap,
        ),
      };

      _polylines = {
        Polyline(
          polylineId: const PolylineId('line_between'),
          visible: true,
          points: [riderLatLng, _ryderLocation],
          color: AppColors.accent,
          width: 5,
        ),
      };
    });
  }

  void startTraversal() {
    timer = Timer.periodic(Duration(seconds: 15), (timer) async {
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
      );
      riderLatLng = LatLng(position.latitude, position.longitude);

      moveToPoint(riderLatLng);
    });
  }

  LatLng restaurantLatLng = LatLng(31.7292, 72.9822);
  double lat = 31.7292;
  double longi = 72.9822;

  Set<Marker> _animatedMarkers = {};

  void moveToPoint(LatLng riderPoint) async {
    final riderBitmap = await CustomMapMarkerBuilder.fromWidget(
      context: context,
      marker: RiderMarkerWidget(),
    );

    final customerBitmap = await CustomMapMarkerBuilder.fromWidget(
      context: context,
      marker: CustomerMarkerWidget(),
    );

    setState(() {
      final resCoords = StorageHelper().getResturantCoords();
      _animatedMarkers = {
        Marker(
          markerId: MarkerId('customer'),
          position: LatLng(resCoords?[0] ?? lat, resCoords?[1] ?? longi),
          icon: customerBitmap,
        ),
        Marker(
          markerId: MarkerId('rider'),
          position: riderPoint,
          icon: riderBitmap,
        ),
      };
      _polylines = {
        Polyline(
          polylineId: PolylineId('route'),
          visible: true,
          points: [
            riderPoint,
            LatLng(resCoords?[0] ?? lat, resCoords?[1] ?? longi),
          ],
          color: Colors.redAccent,
          width: 5,
        ),
      };
    });

    mapController?.animateCamera(CameraUpdate.newLatLng(riderPoint));
    Logger().i("Rider moved to: $riderPoint");
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final wdth = size.width;
    final height = size.height;

    double topPosition = height * 0.44;
    double leftPosition = wdth * 0.85;
    double buttonWidth = wdth * 0.8;

    final locationAsync = ref.watch(locationProvider);

    locationAsync.whenData((locationModel) {
      animateToUserLocation(locationModel.latLng);
    });

    ref.listen(deliveryOrdersProvider, (previous, next) {
      if (next.isNotEmpty && !_hasShownBottomSheet) {
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

    return Builder(
      builder: (context) {
        return Consumer(
          builder: (context, ref, child) {
            final isAccept = ref.watch(riderProvider);
            return Stack(
              children: [
                Positioned.fill(
                  child: GoogleMap(
                    mapType: MapType.satellite,
                    myLocationButtonEnabled: false,
                    indoorViewEnabled: true,
                    trafficEnabled: true,
                    zoomControlsEnabled: false,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController googleMapController) {
                      _controller.complete(googleMapController);
                      mapController = googleMapController;
                      startTraversal();
                    },
                    markers: _animatedMarkers,
                    polylines: _polylines,
                  ),
                ),

                isAccept["isAccept"]
                    ? Positioned(
                      top: topPosition,
                      left: leftPosition - buttonWidth / 2,
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
                    )
                    : SizedBox(),
                isAccept["isAccept"]
                    ? AnimatedRidersDeliveryDetailsWrapper(
                      riderDelivery: riderDeliveryPro,
                    )
                    : SizedBox(),
              ],
            );
          },
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
                        final countdown = ref.watch(riderProvider)['countdown'];
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
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(color: AppColors.black),
                              ),
                              Text(
                                order.pickupItem,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              height(48),
                              Text(
                                order.dropoffLabel,
                                style: Theme.of(context).textTheme.bodyMedium!
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
                            btnTitle: "Accept",
                            onTap: () async {
                              // Update rider state
                              final isAccept = ref.read(riderProvider);
                              ref.read(riderProvider.notifier).state = {
                                ...isAccept,
                                'isAccept': true,
                              };

                              final body = {
                                "estimated_time": "25 minutes",
                                "orderId": order.id,
                              };

                              // Trigger the provider and handle the response
                              final riderDeliveryResponse = await ref.read(
                                acceptedByRiderProvider(body).future,
                              );

                              if (riderDeliveryResponse != null) {
                                // Handle success response
                                Logger().i(
                                  "Order Accepted: ${riderDeliveryResponse.order?.sId}",
                                );
                                final restaurantCoords =
                                    riderDeliveryResponse
                                        .order
                                        ?.addresses
                                        ?.coordinates
                                        ?.coordinates ??
                                    [];
                                StorageHelper().saveResturantCoords(
                                  restaurantCoords,
                                );

                                ref.read(riderDeliveryProvider.notifier).state =
                                    riderDeliveryResponse;
                                timer.cancel();
                                _isMounted = false;
                                _orderCycleTimer?.cancel();

                                Navigator.pop(context);
                                setState(() {
                                  _remainingOrders.clear();
                                });
                              } else {
                                // Handle error if response is null
                                Logger().e("Failed to accept the order.");
                                // You can show a snackbar, toast, or any error UI here
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
