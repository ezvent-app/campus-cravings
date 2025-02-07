import 'package:campus_cravings/src/src.dart';

@RoutePage()
class ProfileTabPage extends ConsumerStatefulWidget {
  const ProfileTabPage({super.key});

  @override
  ConsumerState createState() => _ProfileTabState();
}

class _ProfileTabState extends ConsumerState<ProfileTabPage> {
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
                              borderRadius: BorderRadius.circular(20)),
                          child: const Center(
                            child: Icon(
                              Icons.person,
                              size: 35,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Andrew Ainsley",
                              style: TextStyle(fontSize: 21),
                            ),
                            const SizedBox(height: 5),
                            GestureDetector(
                              onTap: () {
                                context.pushRoute(
                                    ProfileFormRoute(newUser: false));
                              },
                              child: const Text(
                                "Edit Profile",
                                style: TextStyle(color: AppColors.lightText),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border:
                          Border.all(color: const Color(0xFFF4F4F4), width: 2),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {},
                        child: const Center(
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            size: 30,
                            color: Color(0xff443A39),
                          ),
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
                    onPressed: () {
                      context
                          .pushRoute(PaymentMethodsRoute(fromCheckout: false));
                    },
                  ),
                  ProfileOption(
                    icon: 'saved_addresses_icon',
                    label: 'Saved Addresses',
                    onPressed: () {
                      context.pushRoute(const SavedAddressesRoute());
                    },
                  ),
                  ProfileOption(
                    icon: 'promo_offers_icon',
                    label: 'Promo Offers',
                    onPressed: () {
                      context.pushRoute(const PromoCodeRoute());
                    },
                  ),
                ],
              ),
              ProfileGroupButton(
                options: [
                  ProfileOption(
                    icon: 'settings_icon',
                    label: 'Settings',
                    onPressed: () {
                      context.pushRoute(const SettingsRoute());
                    },
                  ),
                  ProfileOption(
                    icon: 'refer_friend_icon',
                    label: 'Refer a Friend/s',
                    onPressed: () {},
                  ),
                  ProfileOption(
                    icon: 'help_icon',
                    label: 'Help',
                    onPressed: () {},
                  ),
                ],
              ),
              ProfileGroupButton(
                options: [
                  ProfileOption(
                    icon: 'logout_icon',
                    label: 'Log Out',
                    onPressed: () {},
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
