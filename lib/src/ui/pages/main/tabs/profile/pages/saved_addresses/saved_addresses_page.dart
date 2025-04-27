import 'package:campuscravings/src/models/User%20Model/user_info_model.dart';
import 'package:campuscravings/src/repository/user_info_repo/user_info_repo.dart';
import 'package:campuscravings/src/src.dart';

@RoutePage()
class SavedAddressesPage extends ConsumerWidget {
  SavedAddressesPage({super.key});

  final UserInfoRepository _userRepository = UserInfoRepository();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = AppLocalizations.of(context)!;

    return BaseWrapper(
      label: locale.savedAddresses,
      child: FutureBuilder<UserModel>(
        future: _userRepository.fetchUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                itemCount: snapshot.data!.userInfo!.addresses!.length,
                physics: BouncingScrollPhysics(),
                separatorBuilder: (context, index) => height(15),
                itemBuilder: (context, index) {
                  final address = snapshot.data!.userInfo!.addresses![index];
                  return InkWellButtonWidget(
                    onTap: () async {},
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
                                      if (address.address == true)
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 6,
                                          ),
                                          margin: const EdgeInsets.only(
                                            left: 30,
                                            bottom: 2,
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
                  onPressed:
                      () => context.pushRoute(CheckOutAddNewAddressRoute()),
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
