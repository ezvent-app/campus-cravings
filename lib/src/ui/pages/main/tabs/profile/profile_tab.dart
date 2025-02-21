import 'package:campus_cravings/src/src.dart';

@RoutePage()
class ProfileTabPage extends StatelessWidget {
  const ProfileTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
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
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.person,
                              size: 35,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Andrew Ainsley",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            height(5),
                            InkWell(
                              onTap: () {
                                context.pushRoute(
                                  ProfileFormRoute(newUser: false),
                                );
                              },
                              child: Text(
                                locale.editProfile,
                                style: TextStyle(color: AppColors.lightText),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xFFF4F4F4),
                        width: 2,
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {},
                        child: const Center(
                          child: Icon(
                            Icons.keyboard_arrow_right,
                            size: 30,
                            color: Color(0xff443A39),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ProfileGroupButton(
                options: [
                  ProfileOption(
                    icon: 'paymentMethod',
                    label: locale.paymentMethods,
                    onPressed: () {
                      context.pushRoute(
                        PaymentMethodsRoute(fromCheckout: false),
                      );
                    },
                  ),
                  ProfileOption(
                    icon: 'address',
                    label: locale.savedAddresses,
                    onPressed: () {
                      context.pushRoute(const SavedAddressesRoute());
                    },
                  ),
                  ProfileOption(
                    icon: 'promo',
                    label: locale.promoCode,
                    onPressed: () {
                      context.pushRoute(const PromoCodeRoute());
                    },
                  ),
                ],
              ),
              ProfileGroupButton(
                options: [
                  ProfileOption(
                    icon: 'notification',
                    label: locale.notifications,
                    onPressed: () {
                      context.pushRoute(const NotificationsRoute());
                    },
                  ),
                  ProfileOption(
                    icon: 'lock',
                    label: locale.changePassword,
                    onPressed: () {
                      context.pushRoute(const ChangePasswordRoute());
                    },
                  ),
                  ProfileOption(
                    icon: 'locale',
                    label: locale.changeLanguage,
                    onPressed: () {
                      context.pushRoute(const ChangeLanguageRoute());
                    },
                  ),
                  ProfileOption(
                    icon: 'help',
                    label: locale.help,
                    onPressed: () {
                      context.pushRoute(const HelpRoute());
                    },
                  ),
                ],
              ),
              ProfileGroupButton(
                options: [
                  ProfileOption(
                    icon: 'logout',
                    label: locale.logOut,
                    onPressed: () => context.pushRoute(LoginRoute()),
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
