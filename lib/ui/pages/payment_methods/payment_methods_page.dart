import 'package:auto_route/auto_route.dart';
import 'package:campus_cravings/constants/app_colors.dart';
import 'package:campus_cravings/router/router.gr.dart';
import 'package:campus_cravings/ui/widgets/png_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class PaymentMethodsPage extends ConsumerStatefulWidget {
  final bool fromCheckout;
  const PaymentMethodsPage({super.key, required this.fromCheckout});

  @override
  ConsumerState createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends ConsumerState<PaymentMethodsPage> {
  final paymentMethods = ['card','venmo','venmo','venmo','venmo'];
  @override
  Widget build(BuildContext context) {
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
                            onPressed: ()=> context.maybePop(),
                            icon: const Icon(Icons.arrow_back, size: 28,),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            'Payment Methods',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
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
                      separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 13),
                      itemBuilder: (BuildContext context, int index) {
                        final category = paymentMethods[index];
                        return Column(
                          children: [
                            Container(
                              width: 80,
                              height: 67,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: index == 0 ? Colors.black : AppColors.textFieldBorder,
                                ),
                              ),
                              child: PngAsset(
                                'payment_${category.toLowerCase()}_icon',
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
                                PngAsset('visa_logo', height: 60, width: 60,),
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
                          height: 73,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(color: const Color(0xffEAEAEA)),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 20, right: 27),
                            child: Row(
                              children: [
                                PngAsset('mastercard_icon', height: 50, width: 50),
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
                        GestureDetector(
                          onTap: (){
                            context.pushRoute(const NewCardRoute());
                          },
                          child: const Text(
                            '+ Add New Card',
                            style: TextStyle(
                              fontSize: 15
                            ),
                          ),
                        )

                      ],
                    ),
                  )

                ],
              ),
            ),
            if(widget.fromCheckout) Container(
              width: double.infinity,
              height: 48,
              margin: const EdgeInsets.only(left: 25, right: 25, bottom: 36),
              child: ElevatedButton(
                onPressed: (){
                  context.maybePop();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.background,// Splash color
                ),
                child: const Text(
                  'Apply',
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