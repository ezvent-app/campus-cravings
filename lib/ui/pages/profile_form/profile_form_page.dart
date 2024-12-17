import 'package:auto_route/auto_route.dart';
import 'package:campus_cravings/constants/app_colors.dart';
import 'package:campus_cravings/router/router.gr.dart';
import 'package:campus_cravings/ui/widgets/custom_text_field.dart';
import 'package:campus_cravings/ui/widgets/png_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ProfileFormPage extends ConsumerStatefulWidget {
  final bool newUser;
  const ProfileFormPage({super.key, required this.newUser});

  @override
  ConsumerState createState() => _ProfileFormPageState();
}

class _ProfileFormPageState extends ConsumerState<ProfileFormPage> {
  final List<String> _roles = ['Student', 'Faculty'];
  late String _selectedRole;

  @override
  void initState() {
    _selectedRole = _roles.first;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 15),
              child: Row(
                children: [
                  if (!widget.newUser) Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: IconButton(
                      onPressed: ()=> context.maybePop(),
                      icon: const Icon(Icons.arrow_back, size: 28,),
                    ),
                  ) else const SizedBox(width: 25,),
                  Padding(
                    padding: EdgeInsets.only(top: widget.newUser ? 12 : 4),
                    child: Text(
                      widget.newUser ? 'Profile Set-up' : 'Edit Profile',
                      style: const TextStyle(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Center(
                    child: SizedBox(
                      width: 64,
                      height: 64,
                      child: Stack(
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle
                            ),
                          ),
                          const Align(
                            alignment: Alignment.bottomRight,
                            child: PngAsset('edit_profile_icon'),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  const CustomTextField(
                    label: 'Enter First Name',
                  ),
                  const SizedBox(height: 16),
                  const CustomTextField(
                    label: 'Enter Last Name',
                  ),
                  const SizedBox(height: 16),
                  const CustomTextField(
                    label: 'Enter Phone Number',
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 3),
                    child: Text(
                      'Select Role',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.lightText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    items: _roles.map((e) {
                      return DropdownMenuItem(value: e, child: Text(e));
                    }).toList(),
                    value: _selectedRole,
                    onChanged: (value) {
                      setState(() {
                        _selectedRole = value!;
                      });
                    },
                    icon: const Icon(Icons.keyboard_arrow_down),
                    iconEnabledColor: AppColors.primary,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: AppColors.textFieldBorder, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: AppColors.textFieldBorder, width: 1.5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Transform.scale(
                        scale: 1.3,
                        child: Checkbox(
                          value: false,
                          onChanged: (value) {
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          side: WidgetStateBorderSide.resolveWith(
                                (states) => const BorderSide(width: 1.0, color: Colors.grey),
                          ),
                        ),
                      ),
                      const SizedBox(width: 7),
                      const Text(
                        'Also Register for Delivery',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff6C7278)
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 18),
                  Container(
                    width: double.infinity,
                    height: 48,
                    margin: const EdgeInsets.only(bottom: 36),
                    child: ElevatedButton(
                      onPressed: (){
                        if(widget.newUser){
                          context.pushRoute(const DeliverySetupRoute());
                        } else {
                          context.maybePop();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.background,// Splash color
                      ),
                      child: Text(
                        widget.newUser ? 'Next' : 'Save',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}