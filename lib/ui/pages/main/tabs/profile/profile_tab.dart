import 'package:auto_route/auto_route.dart';
import 'package:campus_cravings/constants/app_colors.dart';
import 'package:campus_cravings/ui/pages/main/tabs/profile/widgets/profile_group_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ProfileTab extends ConsumerStatefulWidget {
  const ProfileTab({super.key});

  @override
  ConsumerState createState() => _ProfileTabState();
}

class _ProfileTabState extends ConsumerState<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 50),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: const Center(
                            child: Icon(Icons.person, size: 35,),
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Andrew Ainsley",
                              style: TextStyle(fontSize: 21),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "View Profile",
                              style: TextStyle(
                                color: AppColors.lightText
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFFF4F4F4), width: 2),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: (){},
                        child: const Center(
                          child: Icon(Icons.keyboard_arrow_down,size: 30, color: Color(0xff443A39),),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              ProfileGroupButton(
                options: [
                  ProfileOption(
                    icon: 'payment_method_icon',
                    label: 'Payment Methods',
                    onPressed: (){},
                  ),
                  ProfileOption(
                    icon: 'saved_addresses_icon',
                    label: 'Saved Addresses',
                    onPressed: (){},
                  ),
                  ProfileOption(
                    icon: 'promo_offers_icon',
                    label: 'Promo Offers',
                    onPressed: (){},
                  ),
                ],
              ),
              ProfileGroupButton(
                options: [
                  ProfileOption(
                    icon: 'settings_icon',
                    label: 'Settings',
                    onPressed: (){},
                  ),
                  ProfileOption(
                    icon: 'refer_friend_icon',
                    label: 'Refer a Friend/s',
                    onPressed: (){},
                  ),
                  ProfileOption(
                    icon: 'help_icon',
                    label: 'Help',
                    onPressed: (){},
                  ),
                ],
              ),
              ProfileGroupButton(
                options: [
                  ProfileOption(
                    icon: 'logout_icon',
                    label: 'Log Out',
                    onPressed: (){},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}