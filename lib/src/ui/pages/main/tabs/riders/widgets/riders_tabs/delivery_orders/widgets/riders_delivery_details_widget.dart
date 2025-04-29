import 'package:campuscravings/src/models/Rider_delivery_model/Rider_delivery_model.dart';
import 'package:campuscravings/src/repository/rider_delivery_repo/rider_delivery_repo.dart';
import 'package:campuscravings/src/src.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class RidersDeliveryDetailsWidget extends ConsumerStatefulWidget {
  final ScrollController scrollController;
  final bool isMinHeight;

  const RidersDeliveryDetailsWidget({
    super.key,
    required this.scrollController,
    required this.isMinHeight,
  });

  @override
  ConsumerState<RidersDeliveryDetailsWidget> createState() =>
      _RidersDeliveryDetailsWidgetState();
}

class _RidersDeliveryDetailsWidgetState
    extends ConsumerState<RidersDeliveryDetailsWidget> {
  bool isStarted = false;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final riderDelivery = ref.watch(
      riderDeliveryProvider("680fdf337c362f1bc43f631e"),
    );

    return riderDelivery.when(
      data: (RiderDeliveryModel data) {
        // Ensure the data is loaded correctly
        String address =
            data.order!.addresses!.address ?? 'No address available';
        String orderId = data.order!.sId ?? 'No orderId available';
        String storeName = data.order!.restaurantId!.storeName ?? 'Store name';
        String brandName = data.order!.restaurantId!.brandName ?? 'Brand name';
        final items = data.order!.items!;
        String? userName = data.order!.userId?.firstName;
        String? imageUrl = data.order!.userId?.imgUrl;
        String? PhoneNumber = data.order!.userId?.phoneNumber;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text(
                      "Arriving Soon at Pickup Point",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      "${storeName} - ${brandName}",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(color: AppColors.black),
                    ),
                    height(10),
                  ],
                ),
              ),
            ),
            Container(
              height: 10,
              color:
                  widget.isMinHeight ? Colors.white : const Color(0xFFF5F5F5),
            ),
            Expanded(
              child: ListView(
                controller: widget.scrollController,
                padding: EdgeInsets.symmetric(horizontal: 20),
                physics: BouncingScrollPhysics(),
                children: [
                  height(10),
                  Text(
                    locale.deliveryDetails,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  height(20),
                  OrdersInfoWidget(title: locale.address, desc: address),
                  OrdersInfoWidget(
                    title: locale.orderNumber,
                    desc: "#${orderId.substring(0, 6)}",
                  ),
                  const Divider(color: Color(0xFFF5F5F5)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        locale.orderSummary,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: 21,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                  Text(
                    storeName,
                    style: TextStyle(
                      color: Color(0xff656266),
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: List.generate(items!.length, (index) {
                      final item = items?[index];
                      final customzation = item?.itemId!.customization;
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            color: const Color(0xffEFECF0),
                            padding: const EdgeInsets.symmetric(
                              vertical: 2,
                              horizontal: 10,
                            ),
                            child: Text(
                              '${index + 1}',
                              style: Theme.of(
                                context,
                              ).textTheme.titleSmall!.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          width(17),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item?.itemId?.name ?? 'Item name',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleSmall!.copyWith(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Theme(
                                  data: ThemeData(
                                    dividerColor: Colors.transparent,
                                  ),
                                  child: ExpansionTile(
                                    tilePadding: EdgeInsets.zero,
                                    childrenPadding: EdgeInsets.zero,
                                    expandedAlignment: Alignment.topLeft,
                                    title: Text(
                                      locale.showMore,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleSmall!.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Customization heading
                                          Text(
                                            "Customization:",
                                            style:
                                                Theme.of(
                                                  context,
                                                ).textTheme.titleSmall,
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ), // Space between heading and items
                                          // Customization items list
                                          ...List.generate(
                                            customzation!.length,
                                            (index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      vertical: 2.0,
                                                    ),
                                                child: Text(
                                                  customzation[index].name ??
                                                      'Customization name',
                                                  style:
                                                      Theme.of(
                                                        context,
                                                      ).textTheme.bodySmall,
                                                ),
                                              );
                                            },
                                          ),

                                          const SizedBox(
                                            height: 12,
                                          ), // Space before Size row
                                          // Size row
                                          Row(
                                            children: [
                                              Text(
                                                "Size: ",
                                                style:
                                                    Theme.of(
                                                      context,
                                                    ).textTheme.titleSmall,
                                              ),
                                              Text(
                                                item?.itemId?.sizes?[0].name ??
                                                    'Regular',
                                                style:
                                                    Theme.of(
                                                      context,
                                                    ).textTheme.bodySmall,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                  Container(
                    height: 10,
                    color:
                        widget.isMinHeight
                            ? Colors.white
                            : const Color(0xFFF5F5F5),
                  ),
                  if (isStarted)
                    Column(
                      children: [
                        height(10),
                        ListTile(
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(
                              imageUrl ??
                                  'https://www.pngall.com/wp-content/uploads/5/Avatar-Profile-Vector-PNG.png',
                            ),
                          ),
                          title: Text(
                            userName ?? 'User name',
                            style: Theme.of(context).textTheme.titleSmall!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            "Customer",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  final Uri dialUri = Uri(
                                    scheme: 'tel',
                                    path: PhoneNumber,
                                  );

                                  // Check if the URL can be launched
                                  if (await canLaunchUrl(dialUri)) {
                                    await launchUrl(dialUri);
                                  } else {
                                    throw 'Could not launch $dialUri';
                                  }
                                },

                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Card(
                                    shape: const StadiumBorder(),
                                    color: AppColors.black,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: SvgAssets(
                                        "Call",
                                        width: 30,
                                        height: 30,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              width(10),
                              InkWellButtonWidget(
                                borderRadius: BorderRadius.circular(100),
                                onTap:
                                    () => context.pushRoute(
                                      const CheckOutChatRoute(),
                                    ),
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Card(
                                    shape: StadiumBorder(
                                      side: BorderSide(color: AppColors.black),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: SvgAssets(
                                        "Chat",
                                        width: 30,
                                        height: 30,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        height(40),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SlideAction(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff616161),
                            ),
                            onSubmit: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ImageCaptureScreen(),
                                ),
                              );
                              return null;
                            },
                            outerColor: Colors.white,
                            innerColor: AppColors.accent,
                            animationDuration: Duration.zero,
                            sliderButtonIcon: SvgAssets(
                              Images.cart,
                              color: AppColors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(locale.slideToEndDelivery),
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: SlideAction(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff616161),
                        ),
                        onSubmit: () {
                          RiderDelvieryRepo repo = RiderDelvieryRepo();
                          repo.orderAcceptedByRider(
                            '680fdf337c362f1bc43f631e',
                            {"status": "accepted_by_rider"},
                          );
                          setState(() {
                            isStarted = true;
                          });
                          return null;
                        },
                        outerColor: Colors.white,
                        innerColor: AppColors.accent,
                        animationDuration: Duration.zero,
                        sliderButtonIcon: SvgAssets(
                          Images.cart,
                          color: AppColors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(locale.slideToStartDelivery),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
    );
  }
}
