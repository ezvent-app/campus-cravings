import 'package:campuscravings/src/src.dart';

@RoutePage()
class PlacingOrderPage extends ConsumerWidget {
  PlacingOrderPage({super.key});

  final GlobalKey<SlideActionState> _key = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = AppLocalizations.of(context)!;

    Future.delayed(Duration(seconds: 3), () {
      if (context.mounted) {
        context.replaceRoute(DeliveringRoute());
      }
    });

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          locale.searching,
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(color: AppColors.black),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(
                  locale.placeYourOrderOnTheRestaurant,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5),
                Text(
                  locale.reachingOutToActiveStudentzNearby,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
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
                      colors: [Colors.white, Colors.white60, Colors.white12],
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
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: value,
                                ),
                              );
                            },
                            tween: ColorTween(
                              begin: Colors.black.withValues(alpha: .2),
                              end: Colors.black.withValues(alpha: .05),
                            ),
                            duration: const Duration(seconds: 1),
                          ),
                          MirrorAnimationBuilder<Color?>(
                            builder: (context, value, _) {
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 79,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: value,
                                ),
                              );
                            },
                            tween: ColorTween(
                              begin: Colors.black.withValues(alpha: .4),
                              end: Colors.black.withValues(alpha: .3),
                            ),
                            duration: const Duration(seconds: 1),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 129),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black.withValues(alpha: .4),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 145),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 5),
                              shape: BoxShape.circle,
                              color: Colors.black,
                              image: DecorationImage(
                                image: NetworkImage(
                                  "https://s3-alpha-sig.figma.com/img/b271/70bb/8a7db32d95e2d59f88efb80e8417336c?Expires=1740355200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=U1TCftYFII4pIsidEmBhOUs96q6udmiVQ0z1YPKHJJVIjeh~m7r1gTCdGf3S4BIjHAEc9kRQ8fQ52UfUzwENj2Z~m07wfWB3juP9uNTyWdc5vTwW~OAvhjiaQpv9P26dbXTOL1Y~0JoCtG79QCMIKIj7rxV5IiM8wZjAFLAZptmXyP4S1O-miNft6j5CutQKKm-dcR8laXfyjXqsXc0OuVmkHbRuxVSLSrkBTsfoGSEXz7u6TTi5kwNyAResPYpa7VGC3gPrvx2IilBNP7obPKzZ126OBlwNN~hwG3VY9AF1E4gHblmLskYdulaJGBCNMOvtMeGdrWMD3W3-y5ElCw__",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 60,
                        vertical: 40,
                      ),
                      child: SlideAction(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff616161),
                        ),
                        key: _key,
                        onSubmit: () {
                          context.back();
                          return null;
                        },
                        outerColor: Colors.white,
                        innerColor: Colors.black,
                        animationDuration: Duration.zero,
                        sliderButtonIcon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        text: locale.slideToCancel,
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
