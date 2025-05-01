import 'dart:async';
import 'dart:developer';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart'as http;
import 'package:campuscravings/src/constants/storageHelper.dart';
import 'package:campuscravings/src/src.dart';
import 'package:custom_marker_builder/custom_marker_builder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

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
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 12,
  );


  // Add a flag to track if the component is mounted
  bool _isMounted = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setupSocket();
    });

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
          };
        }
      });

      // Join order room only after connection is established
      if (widget.id != null) {
        socketController.emitJoinOrder(widget.id!);
      }
    }
  }

  @override
  void dispose() {
    // Mark as unmounted before disposing
    _isMounted = false;

    // Clean up socket listeners when disposing the widget
    // final socketController = ref.read(socketControllerProvider);
    // socketController.stopListeningForStatusUpdates();

    super.dispose();
  }


  late GoogleMapController mapController;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};

  // Hardcoded locations for demo
  final LatLng riderLocation = const LatLng(33.6844, 72.9843); // G-15 Islamabad
  final LatLng customerLocation = const LatLng(33.6984, 73.0367); // F-8 Islamabad


  Future<void> _initializeMap() async {
    try {

      if (riderLocation == null || customerLocation == null) {
        throw Exception('Missing location data');
      }

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
        markers.add(Marker(
          markerId: MarkerId('rider'),
          position: riderLocation,
          icon: riderIcon,
          infoWindow: InfoWindow(title: 'Rider'),
        ));

        markers.add(Marker(
          markerId: MarkerId('customer'),
          position: customerLocation,
          icon: customerIcon,
          infoWindow: InfoWindow(title: 'Customer'),
        ));
      });

      // Get route between points
      await _getRouteBetweenPoints();

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

      mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
    } catch (e) {
      print('Error initializing map: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _getRouteBetweenPoints() async {
    try {
      PolylinePoints polylinePoints = PolylinePoints();

      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey: apiKey,
        request: PolylineRequest(
          origin: PointLatLng(riderLocation.latitude,riderLocation.longitude),
          destination: PointLatLng(customerLocation.latitude,customerLocation.longitude),
          mode: TravelMode.driving,
        ),
      );

      if (result.points.isEmpty) {
        throw Exception('No route points returned: ${result.errorMessage}');
      }

      List<LatLng> polylineCoordinates = result.points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();

      setState(() {
        polylines.add(Polyline(
          polylineId: PolylineId('route'),
          points: polylineCoordinates,
          color: Colors.red,
          width: 5,
          startCap: Cap.roundCap,
          endCap: Cap.roundCap,
        ));
      });
    } catch (e) {
      print('Error getting route: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not load route: $e')),
      );
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
    print("Step: $step");
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
                          "Prep usually starts within 2-3 minutes.",
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
                      markers: markers,
                      polylines: polylines,
                      onMapCreated: (controller) {
                        setState(() {
                          mapController = controller;
                        });
                        _initializeMap();
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
  (ref) => {'status': ''},
);
