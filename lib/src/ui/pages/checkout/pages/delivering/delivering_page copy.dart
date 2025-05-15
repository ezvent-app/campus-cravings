import 'dart:async';
import 'dart:developer' as dev;
import 'dart:math';

import 'package:campuscravings/src/constants/storageHelper.dart';
import 'package:campuscravings/src/src.dart';
import 'package:campuscravings/src/ui/pages/checkout/pages/delivering/widgets/rider_details_widget.dart';
import 'package:custom_marker_builder/custom_marker_builder.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';

@RoutePage()
class DeliveringPage extends ConsumerStatefulWidget {
  final String? id;
  final String? address;
  final List<dynamic>? items;
  final String? price;
  final String? storeName;
  const DeliveringPage({
    super.key,
    this.id,
    this.storeName,
    this.address,
    this.items,
    this.price,
  });

  @override
  ConsumerState<DeliveringPage> createState() => _DeliveringPageState();
}

class _DeliveringPageState extends ConsumerState<DeliveringPage> {
  int step = 0;
  final messages = [
    "Your order has been placed",
    "Preparing your order",
    "Your order is prepared",
    "Your order is accepted by rider",
    "Your order is on the way",
    "Your order has been delivered",
    "Your order has been cancelled",
    "Your order has been completed",
  ];
  final subMessages = [
    "Waiting for restaturatnt to accept the order",
    "Estimated Preparation Time: ",
    "Waiting for rider to pick up the order",
    "Estimated Delivery Time: ",
    "Estimated Delivery Time: ",
    "You order has arrived! Enjoy your meal",
    "Your order has been cancelled",
    "Your order has been completed",
  ];
  final statuses = [
    "pending",
    "order_accepted",
    "order_prepared",
    "accepted_by_rider",
    "order_dispatched",
    "delivered",
    "cancelled",
    "completed",
  ];

  // Add a flag to track if the component is mounted
  bool _isMounted = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setupSocket();
    });
    startRiderLocationUpdates();
    getCustomerCurrentLocation();
  }

  // New method to setup socket properly
  void _setupSocket() async {
    if (!_isMounted) return;

    final socketController = ref.read(socketControllerProvider);

    // First, ensure socket is connected before setting up listeners
    print("Socket status: ${ref.read(socketStateProvider).status}");
    if (ref.read(socketStateProvider).status != SocketStatus.connected) {
      final token = StorageHelper().getAccessToken();
      if (token == null) return;
      socketController.connect(token);
    }

    // Only after connection is established, set up listeners
    if (_isMounted) {
      socketController.listenForStatusUpdates((Map<String, dynamic> data) {
        print(data['status']);
        if (_isMounted) {
          ref.read(deliveringProvider.notifier).state = {
            'status': data['status'],
            'estimated_time': data['estimated_time'],
          };
        }
      });

      // Join order room only after connection is established
      if (widget.id != null) {
        socketController.emitJoinOrder(widget.id!);
      }
    }
  }

  final PlaceOrderRepository _repository = PlaceOrderRepository();

  Timer? _riderLocationTimer;

  String riderId = '';

  @override
  void dispose() {
    _isMounted = false;
    _riderLocationTimer!.cancel();
    // Clean up socket listeners when disposing the widget
    // final socketController = ref.read(socketControllerProvider);
    // socketController.stopListeningForStatusUpdates();

    super.dispose();
  }

  late GoogleMapController mapController;
  Map<String, Marker> markers = {};
  Set<Polyline> polylines = {};

  LatLng riderLocation = const LatLng(40.7685, 74.9822); // Man Hattan
  LatLng customerLocation = const LatLng(40.7128, 74.0060); // New York

  getCustomerCurrentLocation() async {
    final Position position = await Geolocator.getCurrentPosition();
    setState(() {
      customerLocation = LatLng(position.latitude, position.longitude);
    });
  }

  LatLng? _lastRiderLocation;
  LatLng? _lastCustomerLocation;

  Future<void> _customerinitializeMap() async {
    if (step != 3) return;

    try {
      final riderIcon = await CustomMapMarkerBuilder.fromWidget(
        context: context,
        marker: RiderMarkerWidget(),
      );

      final customerIcon = await CustomMapMarkerBuilder.fromWidget(
        context: context,
        marker: CustomerMarkerWidget(),
      );

      // Add markers
      setState(() {
        markers['rider'] = Marker(
          markerId: MarkerId('rider'),
          position: riderLocation,
          icon: riderIcon,
          infoWindow: InfoWindow(title: 'Rider'),
        );

        markers['customer'] = Marker(
          markerId: MarkerId('customer'),
          position: customerLocation,
          icon: customerIcon,
          infoWindow: InfoWindow(title: 'Customer'),
        );
      });

      // Get route between points

      // Zoom to fit both locations
      final bounds = LatLngBounds(
        southwest: LatLng(
          riderLocation.latitude < customerLocation.latitude
              ? riderLocation.latitude
              : customerLocation.latitude,
          riderLocation.longitude < customerLocation.longitude
              ? riderLocation.longitude
              : customerLocation.longitude,
        ),
        northeast: LatLng(
          riderLocation.latitude > customerLocation.latitude
              ? riderLocation.latitude
              : customerLocation.latitude,
          riderLocation.longitude > customerLocation.longitude
              ? riderLocation.longitude
              : customerLocation.longitude,
        ),
      );

      mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    } catch (e) {
      print('....Error initializing map: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  void startRiderLocationUpdates() {
    _riderLocationTimer = Timer.periodic(Duration(seconds: 15), (timer) async {
      try {
        dev.log("Rider  ID $riderId");

        if (riderId.isNotEmpty) {
          final newLatLng = await _repository.fetchRiderLocation(riderId);
          dev.log("Rider location $newLatLng");
          final riderLatLng = LatLng(newLatLng[1], newLatLng[0]);
          setState(() {
            riderLocation = riderLatLng;
          });
          updateMarkerPosition('rider', riderLatLng);
        } else {
          final riderDetails = await RiderApiService().fetchRiderDetails(
            widget.id ?? '',
          );
          if (riderDetails.id.isNotEmpty) {
            dev.log("Fetched riderId: ${riderDetails.id}");
            setState(() {
              riderId = riderDetails.id;
            });
          }
        }
      } catch (e) {
        debugPrint('Error fetching rider location: $e');
      }
    });
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

  void updateMarkerPosition(String id, LatLng newLatLng) {
    final oldLatLng =
        id == 'rider'
            ? _lastRiderLocation ?? riderLocation
            : _lastCustomerLocation ?? customerLocation;
    if (id == 'rider') _lastRiderLocation = newLatLng;
    if (id == 'customer') _lastCustomerLocation = newLatLng;

    final marker = markers[id];
    if (marker == null) return;

    final updatedMarker = marker.copyWith(
      positionParam: newLatLng,
      rotationParam: _getBearingBetweenTwoPoints(oldLatLng, newLatLng),
    );

    setState(() {
      markers[id] = updatedMarker;
    });

    if (id == 'rider') {
      mapController.animateCamera(CameraUpdate.newLatLng(newLatLng));
    }
  }

  Future<void> _initializeMap() async {
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
      mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
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
    final locale = AppLocalizations.of(context)!;
    final status =
        ref.watch(deliveringProvider)['status'].isEmpty
            ? statuses[0]
            : ref.watch(deliveringProvider)['status'];
    final step = statuses.indexOf(status);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          locale.forDelivering,
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(color: AppColors.black),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              height(10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      messages[step],
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    height(5),
                    Row(
                      children: [
                        Text(
                          subMessages[step] +
                              ((step == 1 || step == 3)
                                  ? ref.watch(
                                        deliveringProvider,
                                      )['estimated_time'] +
                                      " minutes"
                                  : ""),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                        return Row(
                          children: List.generate(5, (index) {
                            return Expanded(
                              child: Container(
                                height: 4,
                                margin: EdgeInsets.only(
                                  right: index == 4 ? 0 : 9,
                                  top: 12,
                                  bottom: 12,
                                ),
                                color: Color(
                                  index < step ? 0xff0F984A : 0xffE5E1E5,
                                ),
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ],
                ),
              ),

              step == 0
                  ? Container(
                    width: double.infinity,
                    height: 300,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(color: Colors.grey.shade300),
                    child: PngAsset("prepare", width: 237, height: 287),
                  )
                  : Expanded(
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: riderLocation,
                        zoom: 12.0,
                      ),

                      indoorViewEnabled: true,
                      trafficEnabled: true,
                      markers: markers.values.toSet(),
                      polylines: polylines,
                      onMapCreated: (controller) {
                        mapController = controller;
                        WidgetsBinding.instance.addPostFrameCallback((_) async {
                          await Future.delayed(Duration(seconds: 1));
                          await _initializeMap();
                        });
                      },
                      myLocationEnabled: false,
                      zoomControlsEnabled: true,
                    ),
                  ),
            ],
          ),
          AnimatedDeliveryDetailsWrapper(
            step: step,
            orderId: widget.id!,
            address: widget.address,
            items: widget.items,
            price: widget.price,
            storeName: widget.storeName,
          ),
        ],
      ),
    );
  }
}

class RiderMarkerWidget extends StatelessWidget {
  const RiderMarkerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black26)],
      ),
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/png/mock_product_1.png'),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomerMarkerWidget extends StatelessWidget {
  const CustomerMarkerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black26)],
      ),
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
        child: Container(decoration: BoxDecoration(shape: BoxShape.circle)),
      ),
    );
  }
}

final deliveringProvider = StateProvider<Map<String, dynamic>>(
  (ref) => {'status': '', 'estimated_time': ''},
);
