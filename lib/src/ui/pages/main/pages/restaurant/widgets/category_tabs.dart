import 'package:campuscravings/src/controllers/restaurant_details_controller.dart';
import 'package:campuscravings/src/src.dart';
import 'package:campuscravings/src/ui/widgets/custom_network_image.dart';
import 'package:get/get.dart';

class CategoryTabs extends ConsumerStatefulWidget {
  final List<Product> products;
  const CategoryTabs({super.key, required this.products});

  @override
  ConsumerState createState() => _CategoryTabsState();
}

class _CategoryTabsState extends ConsumerState<CategoryTabs>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late List<String> _categories;
  late bool _expandedTabBar;

  @override
  void initState() {
    _categories = widget.products.expand((p) => p.categories!).toSet().toList();
    if (_categories.contains('recommended')) {
      _categories.remove('recommended');
      _categories.insert(0, 'recommended');
    }
    _expandedTabBar = _categories.length > 3;
    _tabController = TabController(length: Get.find<RestaurantDetailsController>().getCategoriesLength(), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Expanded(
      child: GetBuilder<RestaurantDetailsController>(
          builder: (controller){
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 24, right: _expandedTabBar ? 0 : 24),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                      indicatorSize: _expandedTabBar
                          ? TabBarIndicatorSize.label
                          : TabBarIndicatorSize.tab,
                      overlayColor: WidgetStatePropertyAll(Colors.transparent),
                      tabAlignment:
                      _expandedTabBar ? TabAlignment.start : TabAlignment.fill,
                      isScrollable: _expandedTabBar,
                      indicator: const UnderlineTabIndicator(
                        borderSide: BorderSide(width: 4, color: Colors.black),
                      ),
                      dividerColor: const Color(0xFFF6F6F6),
                      dividerHeight: 4,
                      controller: _tabController,
                      labelPadding: const EdgeInsets.symmetric(horizontal: 10),
                      tabs: controller.restaurantDetails!.categories.map((e) {
                        return Tab(
                          child: Text(
                            "${e.name}",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: controller.restaurantDetails!.categories.map((e) {
                      final categorizedProducts = widget.products.where((product) {
                        return product.categories!.contains(e);
                      }).toList();
                      return ListView(
                        padding: const EdgeInsets.only(top: 24),
                        physics: BouncingScrollPhysics(),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              '${e.name}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: e.items.length,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 20,
                            ),
                            itemBuilder: (context, index) {
                              return Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 20,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(28),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWellButtonWidget(
                                    borderRadius: BorderRadius.circular(28),
                                    onTap: () {
                                      context.pushRoute(
                                        ProductDetailsRoute(
                                          product: Product(
                                              id: "id",
                                              name: "name",
                                              imageUrl: "imageUrl",
                                              price: 12
                                          ),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              24,
                                            ),
                                            child: CustomNetworkImage(
                                              e.items[index].images[0],
                                              fit: BoxFit.cover,
                                              height: 100,
                                              width: 100,
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${e.items[index].name}',
                                                  style: Theme.of(
                                                    context,
                                                  ).textTheme.titleSmall,
                                                ),
                                                height(7),
                                                Text(
                                                  '\$${e.items[index].price.toStringAsFixed(3)}}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SvgAssets(
                                            'PlusButton',
                                            width: 20,
                                            height: 20,
                                          ),
                                          width(10)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return const SizedBox(height: 20);
                            },
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            );
          }
      )
    );
  }
}
