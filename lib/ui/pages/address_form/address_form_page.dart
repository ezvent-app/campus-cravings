import 'package:auto_route/auto_route.dart';
import 'package:campus_cravings/constants/app_colors.dart';
import 'package:campus_cravings/ui/widgets/custom_text_field.dart';
import 'package:campus_cravings/ui/widgets/png_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class AddressFormPage extends ConsumerStatefulWidget {
  const AddressFormPage({super.key});

  @override
  ConsumerState createState() => _AddressFormPageState();
}

class _AddressFormPageState extends ConsumerState<AddressFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.grey),
                    width: double.infinity,
                    child: const Center(child: Text('Map Widget Here')),
                  ),
                ),
                Positioned.fill(
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 14, left: 14),
                          child: IconButton(
                            style: IconButton.styleFrom(backgroundColor: Colors.white),
                            icon: const Icon(Icons.arrow_back, color: Colors.black, size: 30),
                            onPressed: ()=> context.maybePop(),
                          ),
                        ),
                        const Spacer(),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 18, right: 13),
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: (){
                                },
                                borderRadius: BorderRadius.circular(8),
                                child: const Padding(
                                  padding: EdgeInsets.all(8),
                                  child: PngAsset('move_to_current_location_icon'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 25,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Column(
              children: [
                const CustomTextField(
                  label: 'Enter Building',
                ),
                const SizedBox(height: 10),
                const CustomTextField(
                  label: 'Enter Floor',
                ),
                const SizedBox(height: 10),
                const CustomTextField(
                  label: 'Enter Room Number',
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () => context.maybePop(),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.background,// Splash color
                    ),
                    child: const Text(
                      'Confirm',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 35),

              ],
            ),
          )
        ],
      ),
    );
  }
}