import 'package:campuscravings/src/src.dart';

class HomeLocationWidget extends StatelessWidget {
  const HomeLocationWidget({
    super.key,
    this.icon = Icons.keyboard_arrow_right,
    required this.title,
    required this.subTitle,
  });
  final IconData icon;
  final String title, subTitle;

  Future<List<Map<String, dynamic>>> _loadSavedAddresses() async {
    final prefs = await SharedPreferences.getInstance();
    final resList = prefs.getStringList('selectedAddress');

    if (resList != null) {
      return resList
          .map((item) => jsonDecode(item) as Map<String, dynamic>)
          .toList();
    }
    return [];
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
                    child: FutureBuilder<List<Map<String, dynamic>>>(
                      future: _loadSavedAddresses(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        final addressList = snapshot.data ?? [];

                        return Column(
                          children: [
                            addressList.isEmpty
                                ? Center(child: Text("Address not found"))
                                : ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: addressList.length,
                                  physics: BouncingScrollPhysics(),
                                  separatorBuilder:
                                      (context, index) => height(15),
                                  itemBuilder: (context, index) {
                                    final address = addressList[index];
                                    return InkWellButtonWidget(
                                      onTap: () async {
                                        await SharePreferences.clearValue(
                                          'selectedAddress',
                                        );
                                        await SharePreferences.setList(
                                          key: "selectedAddress",
                                          value: address,
                                        );
                                        context.maybePop();
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
                                                      children: [
                                                        Text(
                                                          address['saveAs'] ??
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
                                                        if (address['isDefault'] ==
                                                            true)
                                                          Container(
                                                            padding:
                                                                const EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 6,
                                                                ),
                                                            margin:
                                                                const EdgeInsets.only(
                                                                  left: 30,
                                                                  bottom: 2,
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
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            address['fullAddress'] ??
                                                                '',
                                                            style:
                                                                Theme.of(
                                                                      context,
                                                                    )
                                                                    .textTheme
                                                                    .bodyMedium,
                                                          ),
                                                        ),
                                                        Consumer(
                                                          builder: (
                                                            context,
                                                            ref,
                                                            child,
                                                          ) {
                                                            final isSelected =
                                                                ref.watch(
                                                                  checkOutProvider,
                                                                );
                                                            return InkWellButtonWidget(
                                                              onTap:
                                                                  () =>
                                                                      ref
                                                                          .read(
                                                                            checkOutProvider.notifier,
                                                                          )
                                                                          .state = !isSelected,
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
                                                                      isSelected
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
                                                                    isSelected
                                                                        ? Center(
                                                                          child: Icon(
                                                                            Icons.done,
                                                                            color:
                                                                                AppColors.white,
                                                                            size:
                                                                                15,
                                                                          ),
                                                                        )
                                                                        : SizedBox(),
                                                              ),
                                                            );
                                                          },
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
              onPressed: () => context.pushRoute(SavedAddressesRoute()),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: const Color(0xffE7E7E7),
                foregroundColor: AppColors.primary,
              ),
              child: Text(
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
