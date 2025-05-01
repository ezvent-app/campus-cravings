import 'package:campuscravings/src/src.dart';

class OrderSummaryWidget extends StatelessWidget {
  final int number;
  final String title;
  final String? size;
  final List<dynamic>? customizations;
  const OrderSummaryWidget({
    super.key,
    required this.number,
    required this.title,
    this.size,
    required this.customizations,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: const Color(0xffEFECF0),
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
          child: Text(
            number.toString(),
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        width(17),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Theme(
                data: ThemeData(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  childrenPadding: EdgeInsets.zero,
                  expandedAlignment: Alignment.topLeft,
                  title: Text(
                    "Show more",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  children: [
                    // Column(
                    //   crossAxisAlignment:
                    //       CrossAxisAlignment.start, // Align everything to start
                    //   children: [
                    //     // Customization heading
                    //     if (customizations != null &&
                    //         customizations!.isNotEmpty)
                    //       Column(
                    //         children: [
                    //           Text(
                    //             "Customization:",
                    //             style: Theme.of(context).textTheme.titleSmall,
                    //           ),
                    //           const SizedBox(
                    //             height: 8,
                    //           ), // Space between heading and items
                    //           // Customization items list
                    //           ...List.generate(customizations!.length, (index) {
                    //             return Padding(
                    //               padding: const EdgeInsets.symmetric(
                    //                 vertical: 2.0,
                    //               ),
                    //               child: Text(
                    //                 customizations![index].name,
                    //                 style:
                    //                     Theme.of(context).textTheme.bodySmall,
                    //               ),
                    //             );
                    //           }),
                    //         ],
                    //       ),
                    //   ],
                    // ),
                    Text(
                      "1x ${size ?? ''}",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
