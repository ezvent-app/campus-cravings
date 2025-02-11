import 'package:campus_cravings/src/src.dart';

@RoutePage()
class PlacingOrderPage extends ConsumerStatefulWidget {
  const PlacingOrderPage({super.key});

  @override
  ConsumerState createState() => _PlacingOrderPageState();
}

class _PlacingOrderPageState extends ConsumerState<PlacingOrderPage> {
  final GlobalKey<SlideActionState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BaseWrapper(
      hasHorizontalPadding: false,
      label: 'Searching',
      child: Column(
        children: [
          Text('Placing your order on the restaurant',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 5),
          Text('Reaching out to active students nearby!',
              style: Theme.of(context).textTheme.bodyLarge),
          Expanded(
            child: Stack(
              children: [
                const Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.only(top: 1),
                    child: PngAsset('map_image', fit: BoxFit.fitWidth),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      stops: [.3, .7, 1],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white,
                        Colors.white60,
                        Colors.white12,
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          MirrorAnimationBuilder<Color?>(
                            builder: (context, value, _) {
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: value),
                              );
                            },
                            tween: ColorTween(
                                begin: Colors.black.withOpacity(.2),
                                end: Colors.black.withOpacity(.05)),
                            duration: const Duration(seconds: 1),
                          ),
                          MirrorAnimationBuilder<Color?>(
                            builder: (context, value, _) {
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 79),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: value),
                              );
                            },
                            tween: ColorTween(
                                begin: Colors.black.withOpacity(.4),
                                end: Colors.black.withOpacity(.3)),
                            duration: const Duration(seconds: 1),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 129),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(.4)),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 156),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 5),
                              shape: BoxShape.circle,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 48),
                      child: SlideAction(
                        text: '       Slide to Cancel',
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff616161),
                        ),
                        key: _key,
                        onSubmit: () {
                          // Future.delayed(
                          //   const Duration(seconds: 1), () => _key.currentState!.reset(),
                          // );
                          // context.maybePop();
                          context.pushRoute(const DeliveringRoute());
                          // final grades = [80, 75, 70];
                          // var total = 0;
                          // for(var i = 0; i < grades.length; i++){
                          //   total = total + grades[i];
                          // }
                          // print('Total: $total');
                          // print('# of Subjects: ${grades.length}');
                          // print('Average: ${total/grades.length}');
                          return null;
                        },
                        // submittedIcon: const Icon(Icons.close, color: Colors.white,),
                        outerColor: Colors.white,
                        innerColor: Colors.black,
                        animationDuration: Duration.zero,
                        sliderButtonIcon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
