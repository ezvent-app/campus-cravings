import 'dart:async';

import 'package:campuscravings/src/src.dart';

class DeliveryOrdersTabWidget extends ConsumerStatefulWidget {
  const DeliveryOrdersTabWidget({super.key});

  @override
  ConsumerState<DeliveryOrdersTabWidget> createState() =>
      _ConsumerDeliveryOrdersTabWidgetState();
}

class _ConsumerDeliveryOrdersTabWidgetState
    extends ConsumerState<DeliveryOrdersTabWidget> {
  late Timer timer;
  @override
  initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      confirmDeliveryBottomSheet();
    });
    startTimer();
    // ref
    //     .read(locationProvider.notifier)
    //     .setupMarkersAndPolylines(
    //       context: context,
    //       ryderLocation: _ryderLocation,
    //       markerWidget: CustomMarkerWidget(),
    //     );

    super.initState();
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

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14,
  );

  final LatLng _ryderLocation = const LatLng(33.642631, 72.961899);

  Future<void> animateToUserLocation(LatLng latLng) async {
    final controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(target: latLng, zoom: 16)),
    );
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

    final locationState = ref.watch(locationProvider);
    final location = locationState.value;
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
                    myLocationEnabled: true,
                    indoorViewEnabled: true,
                    trafficEnabled: true,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    markers: location?.markers ?? {},
                    polylines: location?.polylines ?? {},
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
                    ? AnimatedRidersDeliveryDetailsWrapper()
                    : SizedBox(),
              ],
            );
          },
        );
      },
    );
  }

  confirmDeliveryBottomSheet() {
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
                          '\$5.00',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        width(10),
                        Text(
                          'Guaranteed',
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
                  '1.2 mi',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(color: AppColors.black),
                ),
                Text(
                  'Deliver by 2:38 PM',
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
                                'Big Garden Salad',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              height(48),
                              Text(
                                'Customer Dropoff',
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
                            onTap: () {
                              final isAccept = ref.read(riderProvider);
                              ref.read(riderProvider.notifier).state = {
                                ...isAccept,
                                'isAccept': true,
                              };
                              Navigator.pop(context);
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
