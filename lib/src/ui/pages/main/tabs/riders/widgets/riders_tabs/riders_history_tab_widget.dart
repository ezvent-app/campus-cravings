import 'package:campuscravings/src/repository/rider_repository/history_provider.dart';
import 'package:campuscravings/src/src.dart';

class RidersHistoryTabWidget extends ConsumerWidget {
  const RidersHistoryTabWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;

    // Hardcoded for now, you can pass it as a param or get from auth provider
    const userId = '68091246f1860de92649f3e9';

    final historyAsync = ref.watch(riderHistoryProvider(userId));

    return historyAsync.when(
      loading:
          () => const Center(
            child: SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
      error: (err, stack) => Center(child: Text('Error: $err')),
      data: (history) {
        final orders = history.orders;

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HistoryChartWidget(size: size),
              Column(
                children: List.generate(orders!.length, (index) {
                  final order = orders[index];
                  return Column(
                    children: [
                      const Divider(color: AppColors.dividerColor, height: 40),
                      InkWellButtonWidget(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => OrdersDetailsPage(
                                    storeName: order.restaurant.storeName,
                                    deliveryAddress: order.addresses.address,
                                    orderNumber: order.id.substring(0, 6),
                                  ),
                            ),
                          );
                        },
                        child: SizedBox(
                          height: 95,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PngAsset(
                                'mock_product_1',
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 15,
                                    top: 4,
                                    bottom: 4,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            order.items.isNotEmpty
                                                ? order.items.first.itemId.name
                                                : 'No item',
                                            style:
                                                Theme.of(
                                                  context,
                                                ).textTheme.titleSmall,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            '#${order.id.substring(0, 6)}',
                                            style: Theme.of(
                                              context,
                                            ).textTheme.bodyMedium!.copyWith(
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '\$${order.items[0].itemId.price.toStringAsFixed(2)}',
                                            style:
                                                Theme.of(
                                                  context,
                                                ).textTheme.titleSmall,
                                          ),
                                          Container(
                                            height: 50,
                                            width: 1,
                                            color: AppColors.dividerColor,
                                          ),
                                          Text(
                                            '${order.items[0].quantity} ${locale.items}',
                                            style:
                                                Theme.of(
                                                  context,
                                                ).textTheme.bodyMedium,
                                          ),
                                          Card(
                                            color: AppColors.black,
                                            margin: EdgeInsets.zero,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal:
                                                        Dimensions
                                                            .paddingSizeSmall,
                                                    vertical: 5,
                                                  ),
                                              child: Text(
                                                order.status,
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.bodySmall!.copyWith(
                                                  color: AppColors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
