import 'package:campus_cravings/src/src.dart';

@RoutePage()
class SavedAddressesPage extends ConsumerStatefulWidget {
  const SavedAddressesPage({super.key});

  @override
  ConsumerState createState() => _SavedAddressesPageState();
}

class _SavedAddressesPageState extends ConsumerState<SavedAddressesPage> {
  @override
  Widget build(BuildContext context) {
    return BaseWrapper(
      label: 'Saved Addresses',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(.08), blurRadius: 15)
              ],
            ),
            child: Row(
              children: [
                const PngAsset(
                  'location_pin_circle',
                  height: 52,
                  width: 52,
                ),
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            margin: const EdgeInsets.only(left: 30, bottom: 2),
                            decoration: BoxDecoration(
                                color: const Color(0xFFEBEBEB),
                                borderRadius: BorderRadius.circular(6)),
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
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(.08), blurRadius: 15)
              ],
            ),
            child: Row(
              children: [
                const PngAsset(
                  'location_pin_circle',
                  height: 52,
                  width: 52,
                ),
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            margin: const EdgeInsets.only(left: 30, bottom: 2),
                            decoration: BoxDecoration(
                                color: const Color(0xFFEBEBEB),
                                borderRadius: BorderRadius.circular(6)),
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
              ],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.background, // Splash color
              ),
              child: const Text(
                'Add New Address',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
