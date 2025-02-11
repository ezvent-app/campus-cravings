import 'package:flutter/material.dart';
import 'package:campus_cravings/src/src.dart'; // Import your relevant assets and widgets

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
              bottom: 390,
              top: 410,
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
                      label: 'Enter Building',
                    ),
                    height(20),
                    CustomTextField(
                      label: 'Enter Floor',
                    ),
                    height(20),
                    CustomTextField(
                      label: 'Enter Room Number',
                    ),
                    height(20),

                    // Confirm Button Section
                    RoundedButtonWidget(
                      btnTitle: "Confirm",
                      onTap: () => context
                          .pushRoute(PaymentMethodsRoute(fromCheckout: true)),
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
