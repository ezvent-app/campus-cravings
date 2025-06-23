import 'package:campuscravings/src/models/User%20Model/user_info_model.dart';
import 'package:campuscravings/src/repository/user_info_repo/user_info_repo.dart';
import 'package:campuscravings/src/src.dart';

@RoutePage()
class SavedAddressesPage extends ConsumerStatefulWidget {
  const SavedAddressesPage({super.key});

  @override
  ConsumerState<SavedAddressesPage> createState() => _SavedAddressesPageState();
}

class _SavedAddressesPageState extends ConsumerState<SavedAddressesPage> {
  final UserInfoRepository _userRepository = UserInfoRepository();

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return BaseWrapper(
      label: locale.savedAddresses,
      child: FutureBuilder<UserModel>(
        future: _userRepository.fetchUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.userInfo!.addresses == null) {
            return const Center(child: Text("No addresses found"));
          }

          final addresses = snapshot.data!.userInfo!.addresses!;

          return Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                itemCount: addresses.length,
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) => height(15),
                itemBuilder: (context, index) {
                  final address = addresses[index];

                  return InkWellButtonWidget(
                    onTap: () {},
                    child: Card(
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            const SvgAssets('location', height: 52, width: 52),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        locale.home,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      if (address.address == true)
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 6,
                                          ),
                                          margin: const EdgeInsets.only(
                                            left: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFEBEBEB),
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                          ),
                                          child: Text(
                                            locale.defaultValue,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 10,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    address.address ?? '',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              height(25),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () async {
                    final result = await context.pushRoute(
                      CheckOutAddNewAddressRoute(),
                    );
                    if (result == true) {
                      setState(() {});
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: const Color(0xffE7E7E7),
                    foregroundColor: AppColors.primary,
                  ),
                  child: Text(
                    locale.addNewAddress,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
