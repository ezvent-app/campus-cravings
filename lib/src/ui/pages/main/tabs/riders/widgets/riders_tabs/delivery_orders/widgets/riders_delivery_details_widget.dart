import 'package:campuscravings/src/src.dart';

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
                  "Coffee House - Near Corr Hall",
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
          color: widget.isMinHeight ? Colors.white : const Color(0xFFF5F5F5),
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
              OrdersInfoWidget(
                title: locale.address,
                desc: 'Flat / Suite / Floor: 174',
              ),
              OrdersInfoWidget(title: locale.orderNumber, desc: '#162432'),
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
                'Cafe Shop',
                style: TextStyle(
                  color: Color(0xff656266),
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 20),
              OrderSummaryWidget(locale: locale),
              Container(
                height: 10,
                color:
                    widget.isMinHeight ? Colors.white : const Color(0xFFF5F5F5),
              ),
              if (isStarted)
                Column(
                  children: [
                    height(10),
                    ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                          "https://s3-alpha-sig.figma.com/img/b271/70bb/8a7db32d95e2d59f88efb80e8417336c?Expires=1740355200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=U1TCftYFII4pIsidEmBhOUs96q6udmiVQ0z1YPKHJJVIjeh~m7r1gTCdGf3S4BIjHAEc9kRQ8fQ52UfUzwENj2Z~m07wfWB3juP9uNTyWdc5vTwW~OAvhjiaQpv9P26dbXTOL1Y~0JoCtG79QCMIKIj7rxV5IiM8wZjAFLAZptmXyP4S1O-miNft6j5CutQKKm-dcR8laXfyjXqsXc0OuVmkHbRuxVSLSrkBTsfoGSEXz7u6TTi5kwNyAResPYpa7VGC3gPrvx2IilBNP7obPKzZ126OBlwNN~hwG3VY9AF1E4gHblmLskYdulaJGBCNMOvtMeGdrWMD3W3-y5ElCw__",
                        ),
                      ),
                      title: Text(
                        "Ryder",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      subtitle: Text(
                        "Customer",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: Card(
                              shape: const StadiumBorder(),
                              color: AppColors.black,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: SvgAssets("Call", width: 30, height: 30),
                              ),
                            ),
                          ),
                          width(10),
                          InkWellButtonWidget(
                            borderRadius: BorderRadius.circular(100),
                            onTap: () => context.pushRoute(
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
                          // setState(() {
                          //   isStarted = false;
                          // });
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
              height(20),
            ],
          ),
        ),
      ],
    );
  }
}
