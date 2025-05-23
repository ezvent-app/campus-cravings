import 'package:campuscravings/src/repository/rider_repository/history_provider.dart';
import 'package:campuscravings/src/src.dart';
import 'package:campuscravings/src/ui/widgets/custom_network_image.dart';

class RidersHistoryTabWidget extends ConsumerWidget {
  const RidersHistoryTabWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;

    final historyAsync = ref.watch(riderHistoryProvider);

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
        final filteredOrders =
            orders
                .where(
                  (order) =>
                      order.status == 'delivered' ||
                      order.status == 'cancelled' ||
                      order.status == 'completed',
                )
                .toList();
        if (filteredOrders.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Text(
                'No history found yet!',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HistoryChartWidget(size: size),
              Column(
                children: List.generate(filteredOrders.length, (index) {
                  final order = filteredOrders[index];
                  final allItemNames = order.items.map((e) => e.name).toList();
                  final allSizeNames =
                      order.items.map((e) => e.size?.name).toList();
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
                                    storeName: order.restaurant.name,
                                    deliveryAddress:
                                        order.address.address ?? '123 address',
                                    orderNumber: order.id.substring(0, 6),
                                    customizationList:
                                        order.items[0].customizationList,
                                    name: allItemNames,
                                    quantity: order.items[0].quantity,
                                    items: order.items,
                                    totalPrice: order.totalPrice
                                        .toStringAsFixed(2),
                                    sizeNames: allSizeNames,
                                  ),
                            ),
                          );
                        },
                        child: SizedBox(
                          height: 95,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // PngAsset(
                              //   'mock_product_1',
                              // height: 80,
                              // width: 80,
                              // fit: BoxFit.cover,
                              // borderRadius: BorderRadius.circular(10),
                              // ),
                              CustomNetworkImage(
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                                borderRadius: BorderRadius.circular(10),
                                order.restaurant.image[0],
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
                                                ? order.restaurant.name
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
                                            '\$${order.totalPrice.toStringAsFixed(2)}',
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
                                            '${order.items.length} ${locale.items}',
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
                                                _getOrderStatusText(
                                                  order.status,
                                                ),
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

String _getOrderStatusText(String status) {
  switch (status) {
    case 'delivered':
      return 'Delivered';
    case 'cancelled':
      return 'Cancelled';
    case 'completed':
      return 'Completed';

    default:
      return 'Unknown';
  }
}
