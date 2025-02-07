import 'package:campus_cravings/src/src.dart';

@RoutePage()
class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final _pageController = PageController();

  int _currentPage = 0;
  double _opacity = 1.0; // Initial opacity of the text

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      double pagePosition = _pageController.page ?? _currentPage.toDouble();
      setState(() {
        // Calculate the fade progress to fade in and out smoothly
        double fadeProgress = (pagePosition - _currentPage).abs();
        // Calculate opacity based on how far we are through the page swipe
        if (fadeProgress <= 0.5) {
          // Fade out smoothly as you approach the middle
          _opacity = (1 - fadeProgress * 2).clamp(0.0, 1.0);
        } else {
          // Fade back in smoothly after the middle
          _opacity = ((fadeProgress - 0.5) * 2).clamp(0.0, 1.0);
        }
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: PageView(
              physics: BouncingScrollPhysics(),
              controller: _pageController,
              onPageChanged: (int page) => setState(() => _currentPage = page),
              children: const [
                PngAsset('onboarding_1'),
                PngAsset('onboarding_2'),
                PngAsset('onboarding_3'),
              ],
            ),
          ),
          SmoothPageIndicator(
            controller: _pageController, // PageController
            count: 3,
            effect: const ExpandingDotsEffect(
              activeDotColor: AppColors.accent,
              dotColor: AppColors.accentLight,
              dotHeight: 7,
              dotWidth: 7,
            ),
          ),
          height(10),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                AnimatedOpacity(
                  opacity: _opacity,
                  duration: const Duration(
                      milliseconds: 0), // Duration of fade transition
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeLarge,
                        vertical: Dimensions.paddingSizeSmall),
                    child: Column(
                      children: [
                        Text(
                          _currentPage == 0
                              ? locale.onboardingTitle1
                              : _currentPage == 1
                                  ? locale.onboardingTitle2
                                  : locale.onboardingTitle3,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  fontSize: Dimensions.fontSizeExtraLarge,
                                  fontWeight: FontWeight.w500),
                        ),
                        height(15),
                        Text(
                            _currentPage == 0
                                ? locale.onboardingDesc1
                                : _currentPage == 1
                                    ? locale.onboardingDesc2
                                    : locale.onboardingDesc3,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Card(
                  shape: StadiumBorder(),
                  color: AppColors.primary,
                  child: Padding(
                    padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
                    child: IconButton(
                        onPressed: () => _currentPage == 0
                            ? _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn)
                            : context.replaceRoute(LoginRoute()),
                        icon: Icon(Icons.arrow_forward,
                            color: Colors.white, size: 30)),
                  ),
                ),
                height(40)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
