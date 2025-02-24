import 'package:campus_cravings/src/src.dart';

class NearbyRestaurantsWidget extends ConsumerStatefulWidget {
  const NearbyRestaurantsWidget({super.key});

  @override
  ConsumerState createState() => _NearbyRestaurantsWidgetState();
}

class _NearbyRestaurantsWidgetState
    extends ConsumerState<NearbyRestaurantsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 25, top: 10),
          child: Text('Restaurants Nearby',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  )),
        ),
        const SizedBox(height: 2),
        Column(
          children: List.generate(
            10,
            (index) {
              return InkWell(
                onTap: () {
                  context.pushRoute(const RestaurantRoute());
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  child: Row(
                    children: [
                      PngAsset(
                        'mock_product_1',
                        borderRadius: BorderRadius.circular(200),
                        fit: BoxFit.cover,
                        width: 110,
                        height: 110,
                      ),
                      const SizedBox(width: 25),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bamonte\'s',
                            style: TextStyle(
                                fontSize: 18, color: Color(0xff443A39)),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            'Italian Restaurant',
                            style: TextStyle(
                                fontSize: 14, color: Color(0xffB4B0B0)),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            '8am - 9pm     1 mile away',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff443A39)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
