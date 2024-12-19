import 'package:campus_cravings/ui/widgets/png_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeliveryDetailsWidget extends ConsumerStatefulWidget {
  final ScrollController scrollController;
  final bool isMinHeight;
  const DeliveryDetailsWidget({super.key,
    required this.scrollController,
    required this.isMinHeight
  });

  @override
  ConsumerState createState() => _DeliveryDetailsWidgetState();
}

class _DeliveryDetailsWidgetState extends ConsumerState<DeliveryDetailsWidget> {
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
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 45, vertical: 12),
          child: Text(
            'Your order is in good hands with a fellow Computer Science student!',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700
            ),
          ),
        ),
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
                child: const PngAsset('call_icon', height: 18, width: 18,),
              ),
              Expanded(
                child: Container(
                  height: 36,
                  decoration: BoxDecoration(
                      color: const Color(0xffF5F5F5),
                      borderRadius: BorderRadius.circular(12)
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 8),
                  child: const Text(
                    'Send a message',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
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
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Delivery Details',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Address',
                        style: TextStyle(
                          color: Color(0xff434044),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Flat / Suite / Floor: 174',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Divider(color: Color(0xFFF5F5F5), thickness: 1),
                      const SizedBox(height: 20),
                      const Text(
                        'Order Summary',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w800,
                        ),
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
                        children: List.generate(4, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    color:const Color(0xffEFECF0),
                                    padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                                    child: const Text(
                                      '1',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 17),
                                  const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Mixed Vegetable Salad',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Show more ',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Icon(Icons.keyboard_arrow_down, size: 20, color: Colors.black,)
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                          );
                        },),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '\$15.81',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
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
                  margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xffF5F5F5),
                    borderRadius: BorderRadius.circular(100)
                  ),
                  child: const Text('Add delivery note'),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
