import 'dart:async';

import 'package:campuscravings/src/src.dart';

@RoutePage()
class CheckOutAddNewAddressPage extends ConsumerStatefulWidget {
  const CheckOutAddNewAddressPage({super.key});

  @override
  ConsumerState<CheckOutAddNewAddressPage> createState() =>
      _CheckOutAddNewAddressPageState();
}

class _CheckOutAddNewAddressPageState
    extends ConsumerState<CheckOutAddNewAddressPage> {
  // Text field controllers
  final TextEditingController buildingController = TextEditingController();
  final TextEditingController floorController = TextEditingController();
  final TextEditingController roomController = TextEditingController();

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
  Widget build(BuildContext context) {
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
    final locationMethod = ref.read(locationProvider.notifier);

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
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
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
                      data: (loc) {
                        return Column(
                          children: [
                            CustomTextField(
                              label: locale.location,
                              controller: loc.locationController,
                            ),
                            height(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    textInputType: TextInputType.number,
                                    label: locale.enterFloor,
                                    controller: loc.floorController,
                                  ),
                                ),
                                width(20),
                                Expanded(
                                  child: CustomTextField(
                                    textInputType: TextInputType.number,
                                    label: locale.enterRoomNumber,
                                    controller: loc.roomNoController,
                                  ),
                                ),
                              ],
                            ),
                            height(20),
                            height(10),
                            height(20),
                            RoundedButtonWidget(
                              isLoading: ref.watch(addressSavingProvider),
                              btnTitle: locale.save,
                              onTap: () async {
                                await ref
                                    .read(locationProvider.notifier)
                                    .saveAddress(context);
                              },
                            ),
                            height(20),
                          ],
                        );
                      },
                      loading: () => SizedBox(),
                      error: (e, _) => Text("Error: $e"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    buildingController.dispose();
    floorController.dispose();
    roomController.dispose();
    super.dispose();
  }
}
