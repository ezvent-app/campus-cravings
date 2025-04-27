import 'package:campuscravings/src/models/Rider_History_Model/rider_history.dart';
import 'package:campuscravings/src/src.dart';

@RoutePage()
class OrdersDetailsPage extends StatelessWidget {
  final String? storeName;
  final String? deliveryAddress;
  final String? orderNumber;
  final List<Customization>? customizationList;
  final List<String>? name;
  final int? quantity;
  final String? totalPrice;
  final List<String?>? sizeNames;
  final List<Item>? items;
  const OrdersDetailsPage({
    super.key,
    this.storeName,
    this.deliveryAddress,
    this.orderNumber,
    this.customizationList,
    this.name,
    this.quantity,
    this.totalPrice,
    this.sizeNames,
    this.items,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale.orderDetails,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeDefault,
        ),
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  height(24),
                  OrdersInfoWidget(title: locale.restaurant, desc: storeName!),
                  OrdersInfoWidget(
                    title: locale.deliveryAddress,
                    desc: deliveryAddress!,
                  ),
                  OrdersInfoWidget(
                    title: locale.orderNumber,
                    desc: '#${orderNumber!}',
                  ),
                  height(30),
                  Text(
                    locale.orderSummary,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    storeName!,
                    style: TextStyle(
                      color: Color(0xff656266),
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: List.generate(items!.length, (index) {
                      final item = items?[index];
                      final customzation = item?.customizationList;
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
                                  name![index],
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
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0,
                                          vertical: 8.0,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start, // Align everything to start
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
                                                    customzation[index].name,
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
                                                  "${sizeNames![index]}",
                                                  style:
                                                      Theme.of(
                                                        context,
                                                      ).textTheme.bodySmall,
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
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                  height(30),
                  Text(
                    locale.imageSubmission,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  height(20),
                  Container(
                    height: size.height * .17,
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: NetworkImage(
                          "https://media-cldnry.s-nbcnews.com/image/upload/t_fit-1000w,f_auto,q_auto:best/rockcms/2024-02/burger-king-free-whoppers-2x1-zz-240229-461734.jpg",
                        ),
                      ),
                    ),
                  ),
                  height(30),
                  InkWellButtonWidget(
                    onTap: () => context.pushRoute(ContactSupportRoute()),
                    child: Container(
                      width: size.width,
                      height: 46,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          locale.reportAnIssue,
                          style: Theme.of(context).textTheme.titleSmall!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrdersInfoWidget extends StatelessWidget {
  const OrdersInfoWidget({super.key, required this.title, required this.desc});
  final String title, desc;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        height(10),
        Text(title, style: Theme.of(context).textTheme.bodyMedium),
        Text(
          desc,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
        Divider(color: AppColors.dividerColor),
      ],
    );
  }
}
