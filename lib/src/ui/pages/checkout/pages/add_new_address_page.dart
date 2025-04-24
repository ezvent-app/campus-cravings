import 'dart:async';

import 'package:campuscravings/src/src.dart';

@RoutePage()
class CheckOutAddNewAddressPage extends ConsumerWidget {
  CheckOutAddNewAddressPage({super.key});

  // Text field controllers
  TextEditingController buildingController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController roomController = TextEditingController();

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
    final locale = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    final wdth = size.width;
    final hight = size.height;
    double topPosition = hight * 0.35;
    double leftPosition = wdth * 0.99;
    double buttonWidth = wdth * 0.8;
    double bottomPosition = hight * 0.6;
    double adjustedLeftPosition = leftPosition - buttonWidth / 5;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    final isIOS = Platform.isIOS;

    final loc = ref.watch(locationProvider);

    loc.whenData((locationModel) {
      animateToUserLocation(locationModel.latLng);
    });

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: GoogleMap(
              mapType: MapType.satellite,
              myLocationEnabled: true,
              indoorViewEnabled: true,
              trafficEnabled: true,
              myLocationButtonEnabled: false,

              // onCameraMove: (position) {
              //   ref
              //       .read(locationProvider.notifier)
              //       .updateLocation(position.target);
              // },
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          if (loc.isLoading) const Center(child: CircularProgressIndicator()),
          Positioned(
            top: 50,
            left: 10,
            child: Card(
              shape: StadiumBorder(),
              color: AppColors.white,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(isIOS ? Icons.arrow_back_ios_new : Icons.arrow_back),
              ),
            ),
          ),
          Positioned(
            bottom: bottomPosition,
            top: topPosition,
            left: adjustedLeftPosition,
            right: 20,
            child: SizedBox(
              width: 50,
              height: 50,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                color: AppColors.white,
                child: IconButton(
                  style: IconButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed:
                      () async =>
                          await ref
                              .read(locationProvider.notifier)
                              .refreshLocation(),
                  icon: SvgAssets("location_search"),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Card(
              color: Colors.white,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    loc.when(
                      data:
                          (loc) => Column(
                            children: [
                              CustomTextField(label: locale.location),
                              Text(
                                "LatLng: ${loc.latLng.latitude}, ${loc.latLng.longitude}",
                              ),
                              Text("Address: ${loc.address ?? 'Not found'}"),
                            ],
                          ),
                      loading: () => const CircularProgressIndicator(),
                      error: (e, _) => Text("Error: $e"),
                    ),
                    height(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomTextField(label: locale.enterFloor),
                        ),
                        width(20),
                        Expanded(
                          child: CustomTextField(label: locale.enterRoomNumber),
                        ),
                      ],
                    ),
                    height(20),
                    CustomTextField(
                      label: locale.saveAs,
                      hintText: locale.home,
                    ),
                    height(10),
                    Row(
                      children: [
                        Switch(
                          value: true,
                          onChanged: (value) {},
                          trackColor: WidgetStateProperty.all(Colors.black),
                        ),
                        width(10),
                        Text(
                          locale.setDefault,
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(color: AppColors.black),
                        ),
                      ],
                    ),
                    height(40),
                    RoundedButtonWidget(
                      btnTitle: locale.save,
                      onTap: () => Navigator.pop(context),
                    ),
                    height(20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
