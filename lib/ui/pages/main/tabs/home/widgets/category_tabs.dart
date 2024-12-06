import 'package:campus_cravings/models/product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryTabs extends ConsumerStatefulWidget {
  final List<Product> products;
  const CategoryTabs({super.key, required this.products});

  @override
  ConsumerState createState() => _CategoryTabsState();
}

class _CategoryTabsState extends ConsumerState<CategoryTabs> with TickerProviderStateMixin {
  late TabController _tabController;
  late List<String> _categories;
  @override
  void initState() {
    _categories = widget.products.expand((p) => p.categories!).toSet().toList();
    if (_categories.contains('recommended')) {
      _categories.remove('recommended');
      _categories.insert(0, 'recommended');
    }
    _tabController = TabController(length: _categories.length, vsync: this);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(
                  width: 4,
                  color: Colors.black,
                ),
              ),
              dividerColor: const Color(0xFFF6F6F6),
              dividerHeight: 4,
              isScrollable: true,
              controller: _tabController,
              tabs: _categories.map((e) {
                return Tab(
                  text: e == 'recommended' ? 'Picked For You' : e,
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: ListView(
              children: const [],
            ),
          ),
        ],
      ),
    );
  }
}
