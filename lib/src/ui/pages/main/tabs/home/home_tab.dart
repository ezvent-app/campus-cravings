import 'package:campus_cravings/src/src.dart';
import 'package:flutter/cupertino.dart';

@RoutePage()
class HomeTabPage extends StatelessWidget {
  const HomeTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            height(20),
            Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(2, 3),
                          blurRadius: 5,
                          color: Colors.grey.withValues(alpha: .5))
                    ],
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.white),
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            locale.deliverwithUs,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Icon(Icons.arrow_forward)
                        ]),
                    Text(
                      "6 orders are ready for you to pick up! Start earning with Campus Cravings today.",
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ]),
                )),
            Padding(
              padding: EdgeInsets.all(25),
              child: Text(
                locale.discover,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      style: TextStyle(fontSize: 17),
                      hintText: locale.search,
                      hintStyle:
                          TextStyle(color: Color(0xFFB4B0B0), fontSize: 17),
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(
                          CupertinoIcons.search,
                          color: AppColors.email,
                        ),
                      ),
                    ),
                  ),
                  width(16),
                  Container(
                    width: 57,
                    height: 57,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(
                          color: AppColors.textFieldBorder, width: 2),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () => showSortBottomSheet(context),
                        child: const Center(
                            child: SvgAssets(
                          "filter",
                          width: 24,
                          height: 24,
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: const [
                  CategoriesHorizontalWidget(),
                  PopularHorizontalWidget(),
                  NearbyRestaurantsWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
