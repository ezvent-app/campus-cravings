import 'dart:developer';

import 'package:campuscravings/src/models/User%20Model/user_info_model.dart';
import 'package:campuscravings/src/repository/user_info_repo/user_info_repo.dart';
import 'package:campuscravings/src/src.dart';

class HomeLocationWidget extends ConsumerStatefulWidget {
  const HomeLocationWidget({
    super.key,
    this.icon = Icons.keyboard_arrow_right,
    required this.title,
    required this.subTitle,
  });

  final IconData icon;
  final String title, subTitle;

  @override
  ConsumerState<HomeLocationWidget> createState() => _HomeLocationWidgetState();
}

class _HomeLocationWidgetState extends ConsumerState<HomeLocationWidget> {
  final UserInfoRepository _userRepository = UserInfoRepository();
  Future<UserModel>? _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = _userRepository.fetchUserProfile();
  }

  void _refreshUser() {
    setState(() {
      _userFuture = _userRepository.fetchUserProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          InkWellButtonWidget(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(24),
            ),
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: FutureBuilder<UserModel>(
                      future: _userFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        final addresses = snapshot.data!.userInfo!.addresses!;

                        return Column(
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                              itemCount: addresses.take(2).length,
                              physics: const BouncingScrollPhysics(),
                              separatorBuilder: (context, index) => height(15),
                              itemBuilder: (context, index) {
                                final address = addresses[index];
                                final canDelete = addresses.length > 1;

                                return Consumer(
                                  builder: (context, ref, child) {
                                    final isSelected = ref.watch(
                                      locationProvider,
                                    );
                                    return InkWellButtonWidget(
                                      onTap: () {
                                        ref
                                            .read(locationProvider.notifier)
                                            .selectedAddress(
                                              context,
                                              OrderAddress(
                                                address: address.address,
                                                coordinates:
                                                    address.coordinates,
                                              ),
                                              index,
                                            );
                                        log(
                                          "Selected User address ${address.coordinates!.coordinates}",
                                        );
                                      },
                                      child: Card(
                                        shape: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          borderSide: BorderSide.none,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            children: [
                                              const SvgAssets(
                                                'location',
                                                height: 52,
                                                width: 52,
                                              ),
                                              const SizedBox(width: 16),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          locale.home,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 18,
                                                            color:
                                                                AppColors
                                                                    .primary,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        if (isSelected.value !=
                                                                null &&
                                                            isSelected
                                                                    .value!
                                                                    .selectedIndex ==
                                                                index)
                                                          Container(
                                                            padding:
                                                                const EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 6,
                                                                ),
                                                            margin:
                                                                const EdgeInsets.only(
                                                                  left: 10,
                                                                ),
                                                            decoration: BoxDecoration(
                                                              color:
                                                                  const Color(
                                                                    0xFFEBEBEB,
                                                                  ),
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    6,
                                                                  ),
                                                            ),
                                                            child: Text(
                                                              locale
                                                                  .defaultValue,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 10,
                                                                color:
                                                                    AppColors
                                                                        .primary,
                                                              ),
                                                            ),
                                                          ),
                                                        const Spacer(),
                                                        if (canDelete)
                                                          GestureDetector(
                                                            onTap: () async {
                                                              final confirm = await showDialog<
                                                                bool
                                                              >(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (
                                                                      ctx,
                                                                    ) => AlertDialog(
                                                                      title: const Text(
                                                                        "Delete Address",
                                                                      ),
                                                                      content:
                                                                          const Text(
                                                                            "Are you sure you want to delete this address?",
                                                                          ),
                                                                      actions: [
                                                                        TextButton(
                                                                          onPressed:
                                                                              () => Navigator.of(
                                                                                ctx,
                                                                              ).pop(
                                                                                false,
                                                                              ),
                                                                          child: const Text(
                                                                            "Cancel",
                                                                          ),
                                                                        ),
                                                                        TextButton(
                                                                          onPressed:
                                                                              () => Navigator.of(
                                                                                ctx,
                                                                              ).pop(
                                                                                true,
                                                                              ),
                                                                          child: const Text(
                                                                            "Delete",
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                              );
                                                              if (confirm ==
                                                                  true) {
                                                                await ref
                                                                    .read(
                                                                      locationProvider
                                                                          .notifier,
                                                                    )
                                                                    .deleteAddress(
                                                                      context:
                                                                          context,
                                                                      addressId:
                                                                          address
                                                                              .sId!,
                                                                    );
                                                                _refreshUser();
                                                              }
                                                            },
                                                            child: const Icon(
                                                              Icons.close,
                                                              size: 18,
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            address.address ??
                                                                '',
                                                            style:
                                                                Theme.of(
                                                                      context,
                                                                    )
                                                                    .textTheme
                                                                    .bodyMedium,
                                                          ),
                                                        ),
                                                        InkWellButtonWidget(
                                                          onTap:
                                                              () => ref
                                                                  .read(
                                                                    locationProvider
                                                                        .notifier,
                                                                  )
                                                                  .selectedAddress(
                                                                    context,
                                                                    OrderAddress(
                                                                      address:
                                                                          address
                                                                              .address,
                                                                      coordinates:
                                                                          address
                                                                              .coordinates,
                                                                    ),
                                                                    index,
                                                                  ),
                                                          child: Container(
                                                            width: 20,
                                                            height: 20,
                                                            alignment:
                                                                Alignment
                                                                    .center,
                                                            decoration: BoxDecoration(
                                                              shape:
                                                                  BoxShape
                                                                      .circle,
                                                              color:
                                                                  isSelected.value !=
                                                                              null &&
                                                                          isSelected.value!.selectedIndex ==
                                                                              index
                                                                      ? AppColors
                                                                          .accent
                                                                      : Colors
                                                                          .transparent,
                                                              border: Border.all(
                                                                color:
                                                                    AppColors
                                                                        .accent,
                                                                width: 1,
                                                              ),
                                                            ),
                                                            child:
                                                                isSelected.value !=
                                                                            null &&
                                                                        isSelected.value!.selectedIndex ==
                                                                            index
                                                                    ? const Icon(
                                                                      Icons
                                                                          .done,
                                                                      color:
                                                                          AppColors
                                                                              .white,
                                                                      size: 15,
                                                                    )
                                                                    : const SizedBox(),
                                                          ),
                                                        ),
                                                      ],
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
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(color: AppColors.dividerColor),
          Container(
            width: double.infinity,
            height: 48,
            margin: const EdgeInsets.only(left: 25, right: 25, top: 24),
            child: ElevatedButton(
              onPressed: () async {
                await context.pushRoute(SavedAddressesRoute());
                _refreshUser();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: const Color(0xffE7E7E7),
                foregroundColor: AppColors.primary,
              ),
              child: const Text(
                "Change Address",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ),
          height(30),
        ],
      ),
    );
  }
}

final checkOutProvider = StateProvider((ref) => false);
