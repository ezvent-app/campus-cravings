import 'package:campus_cravings/src/src.dart';

@RoutePage()
class CheckOutMapOrderTrackingPage extends StatelessWidget {
  CheckOutMapOrderTrackingPage({super.key});

  // Text field controllers
  TextEditingController buildingController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController roomController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      body: Stack(
        children: [
          PngAsset(
            "map_image",
          ),
          Positioned(
              top: 50,
              left: 10,
              child: Card(
                shape: StadiumBorder(),
                color: AppColors.white,
                child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back)),
              )),
          Positioned(
              bottom: 410,
              top: 390,
              right: 10,
              child: SizedBox(
                width: 50,
                height: 50,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  color: AppColors.white,
                  child: IconButton(
                    onPressed: () {},
                    icon: SvgAssets(
                      "location_search",
                    ),
                  ),
                ),
              )),
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
                    topRight: Radius.circular(24)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      label: locale.enterBuilding,
                    ),
                    height(20),
                    CustomTextField(
                      label: locale.enterFloor,
                    ),
                    height(20),
                    CustomTextField(
                      label: locale.enterRoomNumber,
                    ),
                    height(20),

                    // Confirm Button Section
                    RoundedButtonWidget(
                      btnTitle: locale.confirm,
                      onTap: () => context.pushRoute(PlacingOrderRoute()),
                    ),
                    height(40),
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
