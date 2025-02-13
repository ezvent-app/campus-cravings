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
        title: Text(locale.deliverTo),
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
                      locale.addNewAddress,
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
