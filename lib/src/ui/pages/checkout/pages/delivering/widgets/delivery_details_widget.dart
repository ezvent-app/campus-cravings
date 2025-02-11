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
  @override
  Widget build(BuildContext context) {
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
        Center(
          child: Text("View Profile",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.black,
                  decoration: TextDecoration.underline)),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 45, vertical: 12),
          child: Text(
              'Your order is in good hands with a fellow Computer Science student!',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AppColors.black)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              stars.length,
              (i) => Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Icon(
                      Icons.star,
                      color: i == 4 ? AppColors.dividerColor : Colors.amber,
                    ),
                  )),
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
                      'Send a message',
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

        ///
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
                      Text('Delivery details',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  fontSize: 21, fontWeight: FontWeight.w800)),
                      height(24),
                      const Text(
                        'Address',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Order summary',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      fontSize: 21,
                                      fontWeight: FontWeight.w800)),
                          TextButton(
                              onPressed: () {},
                              child: Text("View details",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.accent)))
                        ],
                      ),
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
                      Column(
                        children: List.generate(
                          4,
                          (index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    color: const Color(0xffEFECF0),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 10),
                                    child: Text('1',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            )),
                                  ),
                                  const SizedBox(width: 17),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Mixed Vegetable Salad',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                              )),
                                      Row(
                                        children: [
                                          Text('Show more ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  )),
                                          Icon(
                                            Icons.keyboard_arrow_down,
                                            size: 20,
                                            color: Colors.black,
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total',
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
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                      color: const Color(0xffF5F5F5),
                      borderRadius: BorderRadius.circular(100)),
                  child: Text('Add delivery note',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          )),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
