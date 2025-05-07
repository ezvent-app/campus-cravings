import 'package:campuscravings/src/constants/storageHelper.dart'
    show StorageHelper;
import 'package:campuscravings/src/controllers/user_controller.dart';
import 'package:campuscravings/src/models/User%20Model/user_info_model.dart';
import 'package:campuscravings/src/repository/user_info_repo/user_info_repo.dart';
import 'package:campuscravings/src/src.dart';

@RoutePage()
class ProfileTabPage extends ConsumerStatefulWidget {
  const ProfileTabPage({super.key});

  @override
  ConsumerState<ProfileTabPage> createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends ConsumerState<ProfileTabPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final user = ref.watch(userControllerProvider)?.userInfo;
    print("user.imgUrl: ${user?.imgUrl}");
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFA),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 50),
              child: SingleChildScrollView(
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
                                child:
                                    user?.imgUrl != null && user?.imgUrl != ''
                                        ? ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          child: Image.network(
                                            user!.imgUrl!,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    const Center(
                                                      child: Icon(
                                                        Icons.person,
                                                        size: 35,
                                                        color: AppColors.white,
                                                      ),
                                                    ),
                                          ),
                                        )
                                        : const Center(
                                          child: Icon(
                                            Icons.person,
                                            size: 35,
                                            color: AppColors.white,
                                          ),
                                        ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${user?.firstName} ${user?.lastName}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style:
                                          Theme.of(
                                            context,
                                          ).textTheme.titleMedium,
                                    ),
                                    height(5),
                                    InkWellButtonWidget(
                                      onTap: () {
                                        context.pushRoute(
                                          ProfileFormRoute(newUser: false),
                                        );
                                      },
                                      child: Text(
                                        locale.editProfile,
                                        style: TextStyle(
                                          color: AppColors.lightText,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
                            child: InkWellButtonWidget(
                              onTap: () {
                                context.pushRoute(
                                  ProfileFormRoute(newUser: false),
                                );
                              },
                              borderRadius: BorderRadius.circular(8),

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
                            context.pushRoute(SavedAddressesRoute());
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
                            context.pushRoute(ChangePasswordRoute());
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
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder:
                                  (context) => AlertDialog(
                                    title: const Text("Confirm Logout"),
                                    content: const Text(
                                      "Are you sure you want to logout?",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text("No"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          StorageHelper().clear();
                                          Navigator.pop(context);
                                          context.replaceRoute(LoginRoute());
                                        },
                                        child: const Text("Yes"),
                                      ),
                                    ],
                                  ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
