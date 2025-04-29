import 'dart:async';

import 'package:campuscravings/src/constants/storageHelper.dart';
import 'package:campuscravings/src/src.dart';
import 'package:custom_marker_builder/custom_marker_builder.dart';
import 'package:geolocator/geolocator.dart';

@RoutePage()
class DeliveringPage extends ConsumerStatefulWidget {
  final String? id;
  const DeliveringPage({super.key, this.id});

  @override
  ConsumerState<DeliveringPage> createState() => _DeliveringPageState();
}

class _DeliveringPageState extends ConsumerState<DeliveringPage> {
  int step = 0;
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

  LatLng? _customerLocation;

  final LatLng _ryderLocation = const LatLng(33.642631, 72.961899);

  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  // Add a flag to track if the component is mounted
  bool _isMounted = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setupSocket();
    });

    _getCurrentLocation().then((_) {
      if (_isMounted) {
        _setupMarkersAndPolyline();
      }
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
    final socketController = ref.read(socketControllerProvider);
    socketController.stopListeningForStatusUpdates();

    super.dispose();
  }

  Future<void> _setupMarkersAndPolyline() async {
    // Wait until _customerLocation is set
    while (_customerLocation == null) {
      await Future.delayed(Duration(milliseconds: 100));
      if (!_isMounted) return; // Exit if widget is disposed during wait
    }

    final bitmap = await CustomMapMarkerBuilder.fromWidget(
      context: context,
      marker: CustomMarkerWidget(),
    );

    if (!_isMounted) return; // Check if widget is still mounted

    setState(() {
      _markers = {
        Marker(
          markerId: MarkerId('ryder'),
          infoWindow: const InfoWindow(title: 'Ryder Location'),
          position: _ryderLocation,
          icon: bitmap,
        ),
      };

      _polylines = {
        Polyline(
          polylineId: const PolylineId('line_between'),
          visible: true,
          points: [_ryderLocation, _customerLocation!],
          color: AppColors.accent,
          width: 5,
        ),
      };
    });
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    Position position = await Geolocator.getCurrentPosition();

    if (!_isMounted) return; // Check if widget is still mounted

    setState(() {
      _customerLocation = LatLng(position.latitude, position.longitude);
    });

    final GoogleMapController controller = await _controller.future;

    if (!_isMounted) return; // Check if widget is still mounted

    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: _customerLocation!, zoom: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
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
                      "Your order has been placed",
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
                        final status = ref.watch(deliveringProvider)['status'];
                        print("Statusing: $status");
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
                                  index <= statuses.indexOf(status ?? '')
                                      ? 0xff0F984A
                                      : 0xffE5E1E5,
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
                      mapType: MapType.satellite,
                      myLocationEnabled: true,
                      indoorViewEnabled: true,
                      trafficEnabled: true,
                      initialCameraPosition: _kGooglePlex,
                      onMapCreated: (GoogleMapController googleMapController) {
                        _controller.complete(googleMapController);
                      },
                      markers: _markers,
                      polylines: _polylines,
                    ),
                  ),
            ],
          ),
          AnimatedDeliveryDetailsWrapper(step: step),
        ],
      ),
    );
  }
}

class CustomMarkerWidget extends StatelessWidget {
  const CustomMarkerWidget({super.key});

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

final deliveringProvider = StateProvider<Map<String, dynamic>>(
  (ref) => {'status': ''},
);
