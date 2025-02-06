

import 'package:campus_cravings/src/src.dart';

@RoutePage()
class DeliverToPage extends ConsumerStatefulWidget {
  const DeliverToPage({super.key});

  @override
  ConsumerState createState() => _DeliverToPageState();
}

class _DeliverToPageState extends ConsumerState<DeliverToPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 24),
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
                              'Deliver to',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: Colors.white,
                              boxShadow: [BoxShadow(color: Colors.black.withOpacity(.08), blurRadius: 15)],
                            ),
                            child: const Row(
                              children: [
                                PngAsset('current_location_icon', height: 52, width: 52,),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 16),
                                    child: Text(
                                      'Current Live Location',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Color(0xff212121),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 150,
                            margin: const EdgeInsets.symmetric(vertical: 24),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey,
                            ),
                            child: const Center(child: Text('Map Widget Here'),),
                          ),
                          const Divider(height: 48, color: AppColors.dividerColor),
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: Colors.white,
                              boxShadow: [BoxShadow(color: Colors.black.withOpacity(.08), blurRadius: 15)],
                            ),
                            child: Row(
                              children: [
                                const PngAsset('location_pin_circle', height: 52, width: 52,),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            'Home',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                            margin: const EdgeInsets.only(left: 30, bottom: 2),
                                            decoration: BoxDecoration(
                                                color: const Color(0xFFEBEBEB),
                                                borderRadius: BorderRadius.circular(6)
                                            ),
                                            child: const Text(
                                              'Default',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Text(
                                        '5259 Blue Bill Park, PC 4627',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff616161),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: AppColors.accent, width: 3)
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 48,
                      margin: const EdgeInsets.only(left: 25, right: 25, top: 24),
                      child: ElevatedButton(
                        onPressed: () => context.pushRoute(const AddressFormRoute()),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          backgroundColor: const Color(0xffE7E7E7),
                          foregroundColor: AppColors.primary,// Splash color
                        ),
                        child: const Text(
                          'Add New Address',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 0, color: AppColors.dividerColor,),
            const SizedBox(height: 24),
            Container(
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