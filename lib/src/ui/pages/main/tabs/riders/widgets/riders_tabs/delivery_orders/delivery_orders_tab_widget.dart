import 'dart:async';

import 'package:campus_cravings/src/src.dart';

class DeliveryOrdersTabWidget extends ConsumerStatefulWidget {
  const DeliveryOrdersTabWidget({super.key});

  @override
  ConsumerState<DeliveryOrdersTabWidget> createState() =>
      _ConsumerDeliveryOrdersTabWidgetState();
}

class _ConsumerDeliveryOrdersTabWidgetState
    extends ConsumerState<DeliveryOrdersTabWidget> {
  bool isAccept = false;
  int countdown = 10;
  late Timer timer;
  @override
  initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      confirmDeliveryBottomSheet();
    });
    startTimer();
    super.initState();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        setState(() {
          countdown--;
        });
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

  @override
  Widget build(
    BuildContext context,
  ) {
    return Stack(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: isAccept ? 100 : 250),
            child: const PngAsset('map_image', fit: BoxFit.fitWidth),
          ),
        ),
        isAccept
            ? Positioned(
                top: 400,
                bottom: 110,
                left: 210,
                right: 10,
                child: Card(
                  color: AppColors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        PngAsset(
                          "navigation",
                          width: 30,
                          height: 30,
                        ),
                        width(10),
                        Text(
                          "Navigation",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: AppColors.white),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : SizedBox(),
        isAccept ? AnimatedRidersDeliveryDetailsWrapper() : SizedBox()
      ],
    );
  }

  confirmDeliveryBottomSheet() {
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
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: AppColors.black),
                        ),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(
                            value: countdown / 10,
                            strokeWidth: 4,
                            backgroundColor: Colors.grey.shade300,
                            color: AppColors.black,
                          ),
                        ),
                        Text('$countdown sec',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: AppColors.black)),
                      ],
                    ),
                  ],
                ),
                Text(
                  '1.2 mi',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: AppColors.black),
                ),
                Text(
                  'Deliver by 2:38 PM',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: AppColors.black),
                ),
                Divider(
                  color: AppColors.dividerColor,
                ),
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
                              child: Icon(Icons.arrow_drop_down,
                                  color: Colors.white),
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
                              Text('Pickup',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: AppColors.black)),
                              Text('Big Garden Salad',
                                  style: Theme.of(context).textTheme.bodySmall),
                              height(48),
                              Text('Customer Dropoff',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: AppColors.black)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  color: AppColors.dividerColor,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        child: RoundedButtonWidget(
                            btnTitle: "Accept",
                            onTap: () {
                              setState(() {
                                isAccept = true;
                              });
                              Navigator.pop(context);
                            })),
                    width(10),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          side: BorderSide(color: Colors.black),
                          padding: EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: Text('Decline',
                            style:
                                TextStyle(fontSize: 18, color: Colors.black)),
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
          decoration: BoxDecoration(
            color: AppColors.black,
          ),
        ),
      ),
    ));
  }
}

final riderProvider = StateProvider<bool>((ref) => false);
