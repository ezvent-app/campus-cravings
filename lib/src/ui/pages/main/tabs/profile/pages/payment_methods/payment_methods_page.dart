import 'package:campus_cravings/src/src.dart';

@RoutePage()
class PaymentMethodsPage extends StatelessWidget {
  final bool fromCheckout;
  PaymentMethodsPage({super.key, required this.fromCheckout});

  final paymentMethods = ['wallet', 'pp', 'apple', 'venmo', 'venmo'];
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 15),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: IconButton(
                            onPressed: () => context.maybePop(),
                            icon: const Icon(
                              Icons.arrow_back,
                              size: 28,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(locale.paymentMethods,
                              style: Theme.of(context).textTheme.titleMedium),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 123,
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 30, bottom: 26),
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      scrollDirection: Axis.horizontal,
                      itemCount: paymentMethods.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(width: 13),
                      itemBuilder: (BuildContext context, int index) {
                        final category = paymentMethods[index];
                        return Column(
                          children: [
                            Container(
                              width: 80,
                              height: 65,
                              padding: const EdgeInsets.all(
                                  Dimensions.paddingSizeDefault),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.radiusDefault),
                                border: Border.all(
                                  color: index == 0
                                      ? Colors.black
                                      : AppColors.textFieldBorder,
                                ),
                              ),
                              child: SvgAssets(
                                category,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: [
                        Container(
                          height: 73,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(color: const Color(0xffEAEAEA)),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 15, right: 27),
                            child: Row(
                              children: [
                                SvgAssets(
                                  'visa',
                                  height: 60,
                                  width: 60,
                                ),
                                Spacer(),
                                Text(
                                  '2121 6352 8465 ****',
                                  style: TextStyle(
                                    color: Color(0xFFC5C5C5),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          height: 53,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(color: const Color(0xffEAEAEA)),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 20, right: 27),
                            child: Row(
                              children: [
                                SvgAssets('mastercard', height: 33, width: 53),
                                Spacer(),
                                Text(
                                  '2121 6352 8465 ****',
                                  style: TextStyle(
                                    color: Color(0xFFC5C5C5),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        InkWell(
                          onTap: () {
                            context.pushRoute(const NewCardRoute());
                          },
                          child: Text(
                            '+ ${locale.addNewCard}',
                            style: TextStyle(
                                fontSize: 15, color: AppColors.primary),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            if (fromCheckout)
              Container(
                width: double.infinity,
                height: 48,
                margin: const EdgeInsets.only(left: 25, right: 25, bottom: 36),
                child: ElevatedButton(
                  onPressed: () => context.pushRoute(PlacingOrderRoute()),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.background, // Splash color
                  ),
                  child: Text(
                    locale.apply,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
