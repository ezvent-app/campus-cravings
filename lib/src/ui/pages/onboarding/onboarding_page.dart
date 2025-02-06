

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
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page; // Update the current page index
                });
              },
              children: const [
                PngAsset('onboarding_1'),
                PngAsset('onboarding_2'),
              ],
            ),
          ),
          SmoothPageIndicator(
            controller: _pageController, // PageController
            count: 2,
            effect: const ExpandingDotsEffect(
              activeDotColor: AppColors.accent,
              dotColor: AppColors.accentLight,
              dotHeight: 7,
              dotWidth: 7,
            ),
          ),
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
                        horizontal: 20, vertical: 10),
                    child: Column(
                      children: [
                        Text(
                          _currentPage == 0
                              ? 'Your Campus. Your Cravings. Delivered.'
                              : 'Earn with Campus Cravings',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 36),
                        ),
                        height(10),
                        Text(
                          _currentPage == 0
                              ? 'Get all your favorite campus meals, snacks, and drinks delivered anywhere on campus.'
                              : 'Deliver food, earn cash, and support your campus community!',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 17,
                            color: AppColors.lightText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    if (_currentPage == 0) {
                      _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                    } else {
                      context.replaceRoute(const LoginRoute());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20),
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.background // Splash color
                      ),
                  child: const Icon(Icons.arrow_forward,
                      color: Colors.white, size: 30),
                ),
                const SizedBox(height: 40)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
