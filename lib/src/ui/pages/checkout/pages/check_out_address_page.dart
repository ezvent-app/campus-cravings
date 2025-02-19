import 'package:campus_cravings/src/src.dart';

@RoutePage()
class CheckoutAddressPage extends ConsumerWidget {
  const CheckoutAddressPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale.deliverTo,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
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
                  locale.currentLiveLocation,
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
              title: locale.home,
              subTitle: 'Times Square NYC, Manhattan, 27',
            ),
            Container(
              width: double.infinity,
              height: 48,
              margin: const EdgeInsets.only(top: 24),
              child: ElevatedButton(
                onPressed: () =>
                    context.pushRoute(CheckOutAddNewAddressRoute()),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: const Color(0xffE7E7E7),
                  foregroundColor: AppColors.primary,
                ),
                child: Text(
                  locale.addNewAddress,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            height(size.height * .12),
            RoundedButtonWidget(
                btnTitle: locale.apply,
                onTap: () =>
                    context.pushRoute(CheckOutMapOrderTrackingRoute())),
            height(size.height * .03),
          ],
        ),
      ),
    );
  }
}
