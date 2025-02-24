import 'package:campuscravings/src/src.dart';

@RoutePage()
class OrdersDetailsPage extends StatelessWidget {
  const OrdersDetailsPage({super.key});

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
                  OrdersInfoWidget(title: locale.restaurant, desc: "Pizz Hut"),
                  OrdersInfoWidget(
                    title: locale.deliveryAddress,
                    desc: 'Flat / Suite / Floor: 174',
                  ),
                  OrdersInfoWidget(title: locale.orderNumber, desc: '#162432'),
                  height(30),
                  Text(
                    locale.orderSummary,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Pizz Hut',
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
                          "https://s3-alpha-sig.figma.com/img/4f41/2318/07c864fa1ad0906cecdac853a6d4d38f?Expires=1740355200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=gbKWIlt239MAe2JvBH5lU31hP94h8Yk9EGf~u3oYUxIS5xAO0h7irSRwtfbneeBzZRjUJ8h9lRLJ8o9kQ0eJY7IRkNlTnjLP361dRw6Gxe8n5CpxfXHAfwDpHpUF2dUAR19j927ZPOpMzCsrWRTxkFCBLozGEOGe0L6084D6wznpQ4RPRZBf2p83L2FFHWB1JuI-ZF4X~C5CW7APtbaSihPpbN9sD-Q3Jt7eex99oul~SN0JKp~RpX7-mL6mwijT1afUyw~3AnHMNJHnxOhFFv9AXpv5UqebhhrnwAnnQDiAVJ9q1bKkykz3aJdC5hPGgdcuIGAva5j6qADz7NxUNQ__",
                        ),
                      ),
                    ),
                  ),
                  height(30),
                  InkWell(
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
