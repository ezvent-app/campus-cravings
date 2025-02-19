import 'package:campus_cravings/src/src.dart';

class DeliveryDetailsWidget extends ConsumerStatefulWidget {
  final ScrollController scrollController;
  final bool isMinHeight;
  const DeliveryDetailsWidget(
      {super.key, required this.scrollController, required this.isMinHeight});

  @override
  ConsumerState createState() => _DeliveryDetailsWidgetState();
}

class _DeliveryDetailsWidgetState extends ConsumerState<DeliveryDetailsWidget> {
  List stars = [1, 2, 3, 4, 5];
  List tipsList = [1, 5, 10, 15];
  List emojis = ['😣', '☹️', '😶', '😃', '🤩'];

  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final locale = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            height: 80,
            width: 80,
            margin: const EdgeInsets.only(bottom: 9),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  image: NetworkImage(
                      "https://s3-alpha-sig.figma.com/img/b271/70bb/8a7db32d95e2d59f88efb80e8417336c?Expires=1740355200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=U1TCftYFII4pIsidEmBhOUs96q6udmiVQ0z1YPKHJJVIjeh~m7r1gTCdGf3S4BIjHAEc9kRQ8fQ52UfUzwENj2Z~m07wfWB3juP9uNTyWdc5vTwW~OAvhjiaQpv9P26dbXTOL1Y~0JoCtG79QCMIKIj7rxV5IiM8wZjAFLAZptmXyP4S1O-miNft6j5CutQKKm-dcR8laXfyjXqsXc0OuVmkHbRuxVSLSrkBTsfoGSEXz7u6TTi5kwNyAResPYpa7VGC3gPrvx2IilBNP7obPKzZ126OBlwNN~hwG3VY9AF1E4gHblmLskYdulaJGBCNMOvtMeGdrWMD3W3-y5ElCw__")),
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
          ),
        ),
        TextButton(
          onPressed: () => context.pushRoute(DeliveryManProfileRoute()),
          child: Center(
            child: Text(locale.viewProfile,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.black,
                    decoration: TextDecoration.underline)),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 45),
          child: Text(locale.yourOrderGoodHandsFellowComputerScienceStudent,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AppColors.black)),
        ),
        height(10),
        InkWell(
          onTap: () => orderReviewSheetMethod(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                stars.length,
                (i) => Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: SvgAssets(
                      'star',
                      width: 20,
                      height: 20,
                      color: i == 4 ? AppColors.dividerColor : AppColors.yellow,
                    ))),
          ),
        ),
        height(15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                padding: const EdgeInsets.all(9),
                margin: const EdgeInsets.only(right: 18),
                decoration: const BoxDecoration(
                  color: Color(0xffF5F5F5),
                  shape: BoxShape.circle,
                ),
                child: const PngAsset(
                  'call_icon',
                  height: 18,
                  width: 18,
                ),
              ),
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => context.pushRoute(const CheckOutChatRoute()),
                  child: Container(
                    height: 36,
                    decoration: BoxDecoration(
                        color: const Color(0xffF5F5F5),
                        borderRadius: BorderRadius.circular(12)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 17, vertical: 8),
                    child: Text(
                      locale.sendMessage,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: AppColors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 19),
          height: 10,
          color: widget.isMinHeight ? Colors.white : const Color(0xFFF5F5F5),
        ),
        Expanded(
          child: SingleChildScrollView(
            controller: widget.scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: size.height * .26,
                        padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(locale.deliveryComplete,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        fontSize: 21,
                                        fontWeight: FontWeight.w800)),
                            height(5),
                            Container(
                              height: size.height * .17,
                              width: size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                      fit: BoxFit.fitWidth,
                                      image: NetworkImage(
                                          "https://s3-alpha-sig.figma.com/img/4f41/2318/07c864fa1ad0906cecdac853a6d4d38f?Expires=1740355200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=gbKWIlt239MAe2JvBH5lU31hP94h8Yk9EGf~u3oYUxIS5xAO0h7irSRwtfbneeBzZRjUJ8h9lRLJ8o9kQ0eJY7IRkNlTnjLP361dRw6Gxe8n5CpxfXHAfwDpHpUF2dUAR19j927ZPOpMzCsrWRTxkFCBLozGEOGe0L6084D6wznpQ4RPRZBf2p83L2FFHWB1JuI-ZF4X~C5CW7APtbaSihPpbN9sD-Q3Jt7eex99oul~SN0JKp~RpX7-mL6mwijT1afUyw~3AnHMNJHnxOhFFv9AXpv5UqebhhrnwAnnQDiAVJ9q1bKkykz3aJdC5hPGgdcuIGAva5j6qADz7NxUNQ__"))),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 19),
                        height: 10,
                        color: widget.isMinHeight
                            ? Colors.white
                            : const Color(0xFFF5F5F5),
                      ),
                      Text(locale.deliveryDetails,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  fontSize: 21, fontWeight: FontWeight.w800)),
                      height(24),
                      Text(
                        locale.address,
                        style: TextStyle(
                          color: Color(0xff434044),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text('Flat / Suite / Floor: 174',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: AppColors.black)),
                      const Divider(color: Color(0xFFF5F5F5), thickness: 1),
                      const SizedBox(height: 20),
                      Text(locale.orderSummary,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  fontSize: 21, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 2),
                      const Text(
                        'Cafe Shop',
                        style: TextStyle(
                          color: Color(0xff656266),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 20),
                      OrderSummaryWidget(locale: locale),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(locale.total,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    )),
                            Text('\$15.81',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 10,
                  color: const Color(0xFFF5F5F5),
                ),
                InkWell(
                  onTap: () => deliveryNoteSheetMethod(context),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 25),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                        color: const Color(0xffF5F5F5),
                        borderRadius: BorderRadius.circular(100)),
                    child: Text(locale.addDeliveryNote,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            )),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Future<dynamic> orderReviewSheetMethod(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * .8,
            child: Card(
              margin: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          locale.howWasYourOrder,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        width(50),
                        IconButton(
                            onPressed: () =>
                                context.replaceRoute(HomeTabRoute()),
                            icon: Icon(
                              Icons.clear,
                              color: AppColors.email,
                            ))
                      ],
                    ),
                    Text(
                      locale.reviewAboutService,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    height(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          emojis.length,
                          (i) => InkWell(
                                onTap: () {},
                                child: Container(
                                    width: 50,
                                    height: 50,
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey.shade100),
                                    child: Center(
                                        child: Text(
                                      emojis[i].toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ))),
                              )),
                    ),
                    height(20),
                    Text(
                      "${locale.wantToLeaveTipFor} Robert",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.lightText,
                          fontWeight: FontWeight.w600),
                    ),
                    Wrap(
                      children: List.generate(
                          tipsList.length,
                          (i) => InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {
                                setState(() {
                                  selectedIndex = i;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Container(
                                  width: 140,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: selectedIndex == i
                                            ? AppColors.black
                                            : Colors.grey),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Text(
                                        "\$${tipsList[i]}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              color: selectedIndex == i
                                                  ? AppColors.black
                                                  : Colors.grey,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ))),
                    ),
                    height(20),
                    Text(
                      locale.comment,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.lightText,
                          fontWeight: FontWeight.w600),
                    ),
                    height(5),
                    CustomTextField(
                      maxLines: 3,
                    ),
                    height(30),
                    RoundedButtonWidget(
                      btnTitle: locale.continueNext,
                      onTap: () => context.replaceRoute(HomeTabRoute()),
                    )
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  Future<dynamic> deliveryNoteSheetMethod(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.arrow_back,
                          )),
                      width(10),
                      Text(
                        locale.addNote,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  height(10),
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)),
                    child: CustomTextField(
                      hintText: locale.addInstructionsToHelpDelivery,
                      maxLines: 7,
                    ),
                  ),
                  Spacer(),
                  RoundedButtonWidget(
                    btnTitle: locale.continueNext,
                    onTap: () => context.replaceRoute(HomeTabRoute()),
                  ),
                  height(20)
                ],
              ),
            ),
          );
        });
  }
}
