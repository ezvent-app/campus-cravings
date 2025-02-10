import 'package:campus_cravings/src/src.dart';

@RoutePage()
class HomeTabPage extends ConsumerStatefulWidget {
  const HomeTabPage({super.key});

  @override
  ConsumerState createState() => _HomeTabState();
}

class _HomeTabState extends ConsumerState<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            height(20),
            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Deliver with Us",
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
            const Padding(
              padding: EdgeInsets.all(25),
              child: Text(
                'Discover',
                style: TextStyle(
                  color: Color(0xff443A39),
                  fontSize: 36,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  const Expanded(
                    child: CustomTextField(
                      style: TextStyle(fontSize: 17),
                      hintText: 'Search',
                      hintStyle:
                          TextStyle(color: Color(0xFFB4B0B0), fontSize: 17),
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: ImageIcon(
                            AssetImage('assets/images/png/search_icon.png'),
                            color: Color(0xFFB4B0B0),
                            size: 30),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
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
                          child: ImageIcon(
                              AssetImage('assets/images/png/filter_icon.png'),
                              color: Color(0xff443A39),
                              size: 30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
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
