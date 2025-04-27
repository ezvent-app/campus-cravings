import 'dart:async';

import 'package:campuscravings/src/src.dart';

@RoutePage()
class CheckoutAddressPage extends ConsumerWidget {
  CheckoutAddressPage({super.key});

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14,
  );

  Future<void> animateToUserLocation(LatLng latLng) async {
    final controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(target: latLng, zoom: 16)),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final locale = AppLocalizations.of(context)!;

    final locationAsync = ref.watch(locationProvider);

    locationAsync.whenData((locationModel) {
      animateToUserLocation(locationModel.latLng);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale.deliverTo,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
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
            const SizedBox(height: 20),
            SizedBox(
              width: size.width,
              height: size.height * 0.3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    GoogleMap(
                      mapType: MapType.satellite,
                      myLocationEnabled: true,
                      indoorViewEnabled: true,
                      trafficEnabled: true,
                      initialCameraPosition: _kGooglePlex,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                    ),
                  ],
                ),
              ),
            ),
            const Divider(color: AppColors.dividerColor),
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
