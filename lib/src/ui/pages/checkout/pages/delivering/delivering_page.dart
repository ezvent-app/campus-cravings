import 'dart:async';

import 'package:campuscravings/src/src.dart';
import 'package:custom_marker_builder/custom_marker_builder.dart';
import 'package:geolocator/geolocator.dart';

@RoutePage()
class DeliveringPage extends StatefulWidget {
  final String? id;
  const DeliveringPage({super.key, this.id});

  @override
  State<DeliveringPage> createState() => _DeliveringPageState();
}

class _DeliveringPageState extends State<DeliveringPage> {
  int step = 1;
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

  @override
  void initState() {
    super.initState();
    print("Widget ID: ${widget.id}");
    _getCurrentLocation();
    Future.delayed(Duration(seconds: 2), () {
      _setupMarkersAndPolyline();
    });
  }

  Future<void> _setupMarkersAndPolyline() async {
    final bitmap = await CustomMapMarkerBuilder.fromWidget(
      context: context,
      marker: CustomMarkerWidget(),
    );
    setState(() {
      _markers = {
        Marker(
          markerId: MarkerId('ryder'),
          infoWindow: const InfoWindow(title: 'Ryder Location'),
          position: _ryderLocation,
          icon: bitmap,
        ),
        // Marker(
        //   markerId: const MarkerId('ryder'),
        //   position: _ryderLocation,
        //   infoWindow: const InfoWindow(title: 'Ryder Location'),
        //   icon:
        //       _ryderIcon ??
        //       BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        // ),
      };

      _polylines = {
        Polyline(
          polylineId: const PolylineId('line_between'),
          visible: true,
          points: [
            _ryderLocation,
            LatLng(_customerLocation!.latitude, _customerLocation!.longitude),
          ],
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
    setState(() {
      _customerLocation = LatLng(position.latitude, position.longitude);
    });

    final GoogleMapController controller = await _controller.future;
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
                    Row(
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
                              index <= step ? 0xff0F984A : 0xffE5E1E5,
                            ),
                          ),
                        );
                      }),
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
