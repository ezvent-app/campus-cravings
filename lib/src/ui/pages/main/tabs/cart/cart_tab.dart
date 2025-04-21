import 'package:campuscravings/src/src.dart';

@RoutePage()
class CartTabPage extends ConsumerWidget {
  const CartTabPage({super.key, this.isFromNavBar = false});
  final bool isFromNavBar;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: isFromNavBar ? false : true,
        title: Text("Cart", style: Theme.of(context).textTheme.titleMedium),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: List.generate(6, (index) {
                return SizedBox(
                  height: size.height * .17,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PngAsset(
                        'mock_product_1',
                        height: size.height * .13,
                        width: size.width * .3,
                        fit: BoxFit.cover,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mixed Vegetable Salad',
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.black,
                              ),
                            ),
                            height(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$12.00',
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                width(10),
                                QuantitySelectorWidget(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
            height(40),
            CheckoutNavBarWidget(),
          ],
        ),
      ),
    );
  }
}

final tipsProvider = StateProvider((ref) => 0);
