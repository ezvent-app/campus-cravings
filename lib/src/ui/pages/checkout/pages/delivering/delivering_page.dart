import 'package:campuscravings/src/src.dart';

@RoutePage()
class DeliveringPage extends StatelessWidget {
  const DeliveringPage({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          locale.forDelivering,
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(color: AppColors.black),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              height(10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      locale.pickingUpYourorder,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    height(5),
                    Row(
                      children: [
                        Text(
                          locale.arrivingAt,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          '10:15 PM',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                    Row(
                      children: List.generate(5, (index) {
                        return Expanded(
                          child: Container(
                            height: 4,
                            margin: EdgeInsets.only(
                              right: index == 4 ? 0 : 9,
                              top: 12,
                              bottom: 12,
                            ),
                            color: Color(index < 3 ? 0xff0F984A : 0xffE5E1E5),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 250),
                  child: const PngAsset('map_image', fit: BoxFit.fitWidth),
                ),
              ),
            ],
          ),

          const AnimatedDeliveryDetailsWrapper(),
        ],
      ),
    );
  }
}
