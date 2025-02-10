import 'package:campus_cravings/src/src.dart';

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
    _tabController = TabController(length: _categories.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 24, right: _expandedTabBar ? 0 : 24),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                indicatorSize: _expandedTabBar
                    ? TabBarIndicatorSize.label
                    : TabBarIndicatorSize.tab,
                tabAlignment:
                    _expandedTabBar ? TabAlignment.start : TabAlignment.fill,
                isScrollable: _expandedTabBar,
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 4,
                    color: Colors.black,
                  ),
                ),
                dividerColor: const Color(0xFFF6F6F6),
                dividerHeight: 4,
                controller: _tabController,
                labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                tabs: _categories.map((e) {
                  return Tab(
                    child: Text(
                      e == 'recommended' ? 'Picked For You' : e,
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
              children: _categories.map(
                (e) {
                  final categorizedProducts = widget.products.where((product) {
                    return product.categories!.contains(e);
                  }).toList();
                  return ListView(
                    padding: const EdgeInsets.only(top: 24),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          e == 'recommended' ? 'Picked For You' : e,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black),
                        ),
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: categorizedProducts.length,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 20),
                        itemBuilder: (context, index) {
                          return Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black12, blurRadius: 20)
                                ],
                                borderRadius: BorderRadius.circular(28)),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(28),
                                onTap: () {
                                  context.pushRoute(ProductDetailsRoute(
                                      product: categorizedProducts[index]));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(24),
                                        child: const PngAsset(
                                          'mock_product_1',
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
                                              categorizedProducts[index].name,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(height: 3),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    '\$${categorizedProducts[index].price.toStringAsFixed(2)}',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                                const PngAsset(
                                                  'add_icon',
                                                  width: 20,
                                                  height: 20,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
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
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
