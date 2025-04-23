import 'dart:async';

import 'package:campuscravings/src/src.dart';
import 'package:geolocator/geolocator.dart'; // ADD THIS

@RoutePage()
class CheckoutAddressPage extends ConsumerStatefulWidget {
  const CheckoutAddressPage({super.key});

  @override
  ConsumerState<CheckoutAddressPage> createState() =>
      _CheckoutAddressPageState();
}

class _CheckoutAddressPageState extends ConsumerState<CheckoutAddressPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  LatLng? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled
      return Future.error('Location services are disabled.');
    }

    // Check permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever
      return Future.error('Location permissions are permanently denied.');
    }

    // When permissions are granted
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: _currentPosition!, zoom: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale.deliverTo,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Row(
              children: [
                SvgAssets("live_location"),
                width(20),
                Text(
                  locale.currentLiveLocation,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              width: size.width,
              height: size.height * 0.3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: GoogleMap(
                  mapType: MapType.satellite,
                  myLocationEnabled: true,
                  indoorViewEnabled: true,
                  trafficEnabled: true,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController googleMapController) {
                    _controller.complete(googleMapController);
                  },
                ),
              ),
            ),
            Divider(color: AppColors.dividerColor),
            HomeLocationWidget(
              icon: Icons.circle_outlined,
              title: locale.home,
              subTitle: 'Times Square NYC, Manhattan, 27',
            ),
            SizedBox(height: size.height * .05),
            RoundedButtonWidget(
              btnTitle: locale.apply,
              onTap: () => context.pushRoute(PlacingOrderRoute()),
            ),
          ],
        ),
      ),
    );
  }
}
