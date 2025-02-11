import 'package:campus_cravings/src/src.dart';

@RoutePage()
class CheckoutAddressPage extends ConsumerStatefulWidget {
  const CheckoutAddressPage({super.key});

  @override
  ConsumerState createState() => _ConsumerAddressPageState();
}

class _ConsumerAddressPageState extends ConsumerState<CheckoutAddressPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Deliver to"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        physics: BouncingScrollPhysics(),
        child: Column(
          spacing: 20,
          children: [
            Row(
              children: [
                SvgAssets("live_location"),
                width(20),
                Text(
                  "Current Live Location",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            PngAsset(
              "live_loc_map",
              width: size.width,
              height: size.height * .2,
              fit: BoxFit.fitWidth,
            ),
            Divider(
              color: AppColors.dividerColor,
            ),
            HomeLocationWidget(
              icon: Icons.circle_outlined,
              title: "Home",
              subTitle: 'Times Square NYC, Manhattan, 27',
            ),
            SizedBox(
              width: size.width,
              height: size.height * .08,
              child: Card(
                color: AppColors.dividerColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      "Add New Address",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
            height(size.height * .12),
            RoundedButtonWidget(
                btnTitle: "Apply",
                onTap: () =>
                    context.pushRoute(CheckOutMapOrderTrackingRoute())),
            height(size.height * .03),
          ],
        ),
      ),
    );
  }
}
