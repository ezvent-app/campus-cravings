import 'package:campus_cravings/src/src.dart';

@RoutePage()
class DeliveringPage extends ConsumerStatefulWidget {
  const DeliveringPage({super.key});

  @override
  ConsumerState createState() => _DeliveringPageState();
}

class _DeliveringPageState extends ConsumerState<DeliveringPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BaseWrapper(
          hasHorizontalPadding: false,
          label: 'For Delivering',
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Picking up your order...',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontSize: Dimensions.fontSizeExtraLarge,
                                fontWeight: FontWeight.w800)),
                    const SizedBox(height: 5),
                    const Row(
                      children: [
                        Text(
                          'Arriving at ',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff656266)),
                        ),
                        Text(
                          '10:15',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff434044)),
                        ),
                      ],
                    ),
                    Row(
                      children: List.generate(5, (index) {
                        return Expanded(
                          child: Container(
                            height: 4,
                            margin: EdgeInsets.only(
                                right: index == 4 ? 0 : 9, top: 12, bottom: 12),
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
              )
            ],
          ),
        ),
        const AnimatedDeliveryDetailsWrapper()
      ],
    );
  }
}
