import 'package:campuscravings/src/src.dart';

@RoutePage()
class OrdersDetailsPage extends StatelessWidget {
  final String? storeName;
  final String? deliveryAddress;
  final String? orderNumber;

  const OrdersDetailsPage({
    super.key,
    this.storeName,
    this.deliveryAddress,
    this.orderNumber,
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
                  OrderSummaryWidget(locale: locale),
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
