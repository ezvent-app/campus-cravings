import 'package:campus_cravings/src/src.dart';

@RoutePage()
class CheckOutAddNewAddressPage extends StatelessWidget {
  CheckOutAddNewAddressPage({super.key});

  // Text field controllers
  TextEditingController buildingController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController roomController = TextEditingController();

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
    return Scaffold(
      body: Stack(
        children: [
          PngAsset("map_image", height: size.height, fit: BoxFit.cover),
          Positioned(
            top: 50,
            left: 10,
            child: Card(
              shape: StadiumBorder(),
              color: AppColors.white,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back),
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
                  onPressed: () {},
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
                    CustomTextField(label: locale.location),
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
                        Switch.adaptive(value: true, onChanged: (value) {}),
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
