// import 'package:campuscravings/src/src.dart';

// @RoutePage()
// class DeliverToPage extends ConsumerWidget {
//   const DeliverToPage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final locale = AppLocalizations.of(context)!;
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 20, bottom: 24),
//                       child: Row(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 15),
//                             child: IconButton(
//                               onPressed: () => context.maybePop(),
//                               icon: const Icon(Icons.arrow_back, size: 28),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(top: 4),
//                             child: Text(
//                               locale.deliverTo,
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 25),
//                       child: Column(
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 20,
//                               vertical: 12,
//                             ),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(24),
//                               color: Colors.white,
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withValues(alpha: .08),
//                                   blurRadius: 15,
//                                 ),
//                               ],
//                             ),
//                             child: Row(
//                               children: [
//                                 PngAsset(
//                                   'current_location_icon',
//                                   height: 52,
//                                   width: 52,
//                                 ),
//                                 Expanded(
//                                   flex: 2,
//                                   child: Padding(
//                                     padding: EdgeInsets.only(left: 16),
//                                     child: Text(
//                                       locale.currentLiveLocation,
//                                       maxLines: 2,
//                                       overflow: TextOverflow.ellipsis,
//                                       style: TextStyle(
//                                         color: Color(0xff212121),
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             height: 150,
//                             margin: const EdgeInsets.symmetric(vertical: 24),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(12),
//                               color: Colors.grey,
//                             ),
//                             child: Center(child: Text(locale.mapWidgetHere)),
//                           ),
//                           const Divider(
//                             height: 48,
//                             color: AppColors.dividerColor,
//                           ),
//                           Container(
//                             padding: const EdgeInsets.all(20),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(24),
//                               color: Colors.white,
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withValues(alpha: .08),
//                                   blurRadius: 15,
//                                 ),
//                               ],
//                             ),
//                             child: Row(
//                               children: [
//                                 const SvgAssets(
//                                   'live_location',
//                                   height: 52,
//                                   width: 52,
//                                 ),
//                                 width(16),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Text(
//                                             locale.home,
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.w700,
//                                               fontSize: 18,
//                                             ),
//                                           ),
//                                           Container(
//                                             padding: const EdgeInsets.symmetric(
//                                               horizontal: 10,
//                                               vertical: 6,
//                                             ),
//                                             margin: const EdgeInsets.only(
//                                               left: 30,
//                                               bottom: 2,
//                                             ),
//                                             decoration: BoxDecoration(
//                                               color: const Color(0xFFEBEBEB),
//                                               borderRadius:
//                                                   BorderRadius.circular(6),
//                                             ),
//                                             child: Text(
//                                               locale.defaultValue,
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.w600,
//                                                 fontSize: 10,
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       const Text(
//                                         '5259 Blue Bill Park, PC 4627',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.w500,
//                                           color: Color(0xff616161),
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 const SizedBox(width: 12),
//                                 Consumer(
//                                   builder: (context, ref, child) {
//                                     final isSelected =
//                                         ref.watch(checkOutProvider);
//                                     return InkWellButtonWidget(
//                                       onTap: () => ref
//                                           .read(checkOutProvider.notifier)
//                                           .state = true,
//                                       child: Container(
//                                         width: 30,
//                                         height: 20,
//                                         decoration: BoxDecoration(
//                                           shape: BoxShape.circle,
//                                           color: isSelected
//                                               ? AppColors.accent
//                                               : Colors.transparent,
//                                           border: Border.all(
//                                             color: AppColors.accent,
//                                             width: 3,
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 )
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       width: double.infinity,
//                       height: 48,
//                       margin: const EdgeInsets.only(
//                         left: 25,
//                         right: 25,
//                         top: 24,
//                       ),
//                       child: ElevatedButton(
//                         onPressed: () =>
//                             context.pushRoute(CheckOutAddNewAddressRoute()),
//                         style: ElevatedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           backgroundColor: const Color(0xffE7E7E7),
//                           foregroundColor: AppColors.primary,
//                         ),
//                         child: Text(
//                           locale.addNewAddress,
//                           style: TextStyle(fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             height(24),
//             Container(
//               width: double.infinity,
//               height: 48,
//               margin: const EdgeInsets.only(left: 25, right: 25, bottom: 36),
//               child: ElevatedButton(
//                 onPressed: () {
//                   context.maybePop();
//                 },
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   backgroundColor: AppColors.primary,
//                   foregroundColor: AppColors.background, // Splash color
//                 ),
//                 child: Text(
//                   locale.apply,
//                   style: TextStyle(fontWeight: FontWeight.w500),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
