import 'package:campuscravings/src/src.dart';

@RoutePage()
class ContactSupportPage extends StatelessWidget {
  const ContactSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale.contactSupport,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            // Expanded(
            //   child: ListView.builder(
            //     physics: BouncingScrollPhysics(),
            //     itemCount: 0,
            //     shrinkWrap: true,
            //     itemBuilder: (context, index) {
            //       final chat = {
            //         "message": "Hello, how can I help you?",
            //         "isRead": true,
            //         "timestamp": "12:00 PM",
            //       };
            //       return Padding(
            //         padding: const EdgeInsets.symmetric(vertical: 10),
            //         child: Column(
            //           crossAxisAlignment:
            //               chat.isRead
            //                   ? CrossAxisAlignment.end
            //                   : CrossAxisAlignment.start,
            //           children: [
            //             Container(
            //               decoration: BoxDecoration(
            //                 color:
            //                     chat.isRead
            //                         ? AppColors.black
            //                         : AppColors.halfWhite,
            //                 borderRadius:
            //                     chat.isRead
            //                         ? BorderRadius.only(
            //                           topLeft: Radius.circular(16),
            //                           topRight: Radius.circular(16),
            //                           bottomLeft: Radius.circular(16),
            //                           bottomRight: Radius.circular(2),
            //                         )
            //                         : BorderRadius.only(
            //                           topLeft: Radius.circular(2),
            //                           topRight: Radius.circular(16),
            //                           bottomLeft: Radius.circular(16),
            //                           bottomRight: Radius.circular(16),
            //                         ),
            //               ),
            //               child: Padding(
            //                 padding: const EdgeInsets.all(20),
            //                 child: Text(
            //                   chat.message,
            //                   style: TextStyle(
            //                     color:
            //                         chat.isRead
            //                             ? AppColors.white
            //                             : AppColors.black,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //             chat.isRead
            //                 ? Row(
            //                   mainAxisAlignment: MainAxisAlignment.end,
            //                   children: [
            //                     Text(
            //                       chat.timestamp,
            //                       style: Theme.of(context).textTheme.bodySmall,
            //                     ),
            //                     width(5),
            //                     Icon(Icons.done_all),
            //                   ],
            //                 )
            //                 : Text(chat.timestamp),
            //           ],
            //         ),
            //       );
            //     },
            //   ),
            // ),
            // height(40),
            // Row(
            //   children: [
            //     Expanded(
            //       child: Container(
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(16),
            //           color: AppColors.halfWhite,
            //         ),
            //         child: TextField(
            //           onChanged: (value) {},
            //           decoration: InputDecoration(
            //             hintText: locale.typeMessage,
            //             hintStyle: Theme.of(context).textTheme.bodyMedium,
            //             border: InputBorder.none,
            //           ),
            //         ),
            //       ),
            //     ),
            //     width(12),
            //     IconButton(icon: SvgAssets("Navigation"), onPressed: () {}),
            //   ],
            // ),
            // height(20),
          ],
        ),
      ),
    );
  }
}
