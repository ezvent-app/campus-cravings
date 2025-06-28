import 'package:campuscravings/src/controllers/product_details_controller.dart';
import 'package:campuscravings/src/controllers/restaurant_details_controller.dart';
import 'package:campuscravings/src/models/restaurant_details_model.dart';
import 'package:campuscravings/src/src.dart';
import 'package:campuscravings/src/ui/widgets/custom_network_image.dart';
import 'package:get/get.dart';

class CategoryTabs extends ConsumerStatefulWidget {
  final List<Product> products;
  final List<double> coordinates;
  final String? initialItemId;
  const CategoryTabs({
    super.key,
    required this.products,
    required this.coordinates,
    this.initialItemId,
  });

  @override
  ConsumerState createState() => _CategoryTabsState();
}

class _CategoryTabsState extends ConsumerState<CategoryTabs>
    with TickerProviderStateMixin {
  late Map<String, ScrollController> _scrollControllers;
  late TabController _tabController;
  late List<String> _categories;
  late bool _expandedTabBar;
  late List<Category> _visibleCategories;
  @override
  void initState() {
    final controller = Get.find<RestaurantDetailsController>();
    final allCategories = controller.restaurantDetails!.categories;

    // Filter to only the category containing the initial item
    if (widget.initialItemId != null) {
      _visibleCategories =
          allCategories
              .where(
                (cat) =>
                    cat.items.any((item) => item.id == widget.initialItemId),
              )
              .toList();
    } else {
      _visibleCategories = allCategories;
    }

    _categories = _visibleCategories.map((c) => c.name).toList();
    _expandedTabBar = _categories.length > 3;

    _tabController = TabController(length: _categories.length, vsync: this);

    _scrollControllers = {
      for (var category in _categories) category: ScrollController(),
    };

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialItemId != null) {
        for (var i = 0; i < _visibleCategories.length; i++) {
          final itemIndex = _visibleCategories[i].items.indexWhere(
            (item) => item.id == widget.initialItemId,
          );

          if (itemIndex != -1) {
            _tabController.animateTo(i);
            Future.delayed(const Duration(milliseconds: 400), () {
              _scrollControllers[_visibleCategories[i].name]?.animateTo(
                itemIndex * 150.0,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            });
            break;
          }
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollControllers.values.forEach((c) => c.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Expanded(
      child: GetBuilder<RestaurantDetailsController>(
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 24,
                  right: _expandedTabBar ? 0 : 24,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TabBar(
                    indicatorSize:
                        _expandedTabBar
                            ? TabBarIndicatorSize.label
                            : TabBarIndicatorSize.tab,
                    overlayColor: WidgetStatePropertyAll(Colors.transparent),
                    tabAlignment:
                        _expandedTabBar
                            ? TabAlignment.start
                            : TabAlignment.fill,
                    isScrollable: _expandedTabBar,
                    indicator: const UnderlineTabIndicator(
                      borderSide: BorderSide(width: 4, color: Colors.black),
                    ),
                    dividerColor: const Color(0xFFF6F6F6),
                    dividerHeight: 4,
                    controller: _tabController,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 10),
                    tabs:
                        _visibleCategories.map((e) {
                          return Tab(
                            child: Text(
                              e.name,
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
                child: Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children:
                        _visibleCategories.map((category) {
                          final isInitialItemView =
                              widget.initialItemId != null;

                          final items =
                              isInitialItemView
                                  ? category.items
                                      .where(
                                        (item) =>
                                            item.id == widget.initialItemId,
                                      )
                                      .toList()
                                  : category.items;

                          // If in initialItemId mode and no items match, return an empty widget
                          if (isInitialItemView && items.isEmpty) {
                            return const Center(child: Text("No item found"));
                          }

                          return ListView.separated(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 20,
                            ),
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              final item = items[index];
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
                                      Get.find<ProductDetailsController>()
                                          .setProductId(item.id);
                                      context.pushRoute(
                                        ProductDetailsRoute(
                                          restCoordinates: widget.coordinates,
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
                                              item.image[0],
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
                                                  item.name,
                                                  style:
                                                      Theme.of(
                                                        context,
                                                      ).textTheme.titleSmall,
                                                ),
                                                const SizedBox(height: 7),
                                                Text(
                                                  _getItemPrice(item),
                                                  style:
                                                      Theme.of(
                                                        context,
                                                      ).textTheme.titleSmall,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SvgAssets(
                                            'PlusButton',
                                            width: 20,
                                            height: 20,
                                          ),
                                          const SizedBox(width: 10),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder:
                                (_, __) => const SizedBox(height: 20),
                          );
                        }).toList(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _getItemPrice(Item item) {
    if (item.price == 0) {
      final sizePrices = item.sizes.map((s) => s.price);
      if (sizePrices.isNotEmpty) {
        final minSizePrice = sizePrices.reduce((a, b) => a < b ? a : b);
        return '\$${minSizePrice.toStringAsFixed(2)}';
      }
    }
    return '\$${item.price.toStringAsFixed(2)}';
  }
}
