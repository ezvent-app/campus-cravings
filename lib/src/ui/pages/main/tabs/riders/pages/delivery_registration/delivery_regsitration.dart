import 'package:campuscravings/src/constants/storageHelper.dart';
import 'package:campuscravings/src/repository/rider_delivery_repo/rider_regsitration_repo.dart';
import 'package:campuscravings/src/src.dart';
import 'package:campuscravings/src/ui/widgets/web_view_striper.dart';

@RoutePage()
class DeliveryRegistrationPage extends ConsumerWidget {
  const DeliveryRegistrationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              Column(
                children: [
                  const Text(
                    "You're almost ready to\nstart delivering!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "But first, we need a few more details\nto complete your profile.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () =>
                          context.pushRoute(StudentProfileDetailsRoute()),

                      // () async {
                      //   final userID = StorageHelper().getUserId();

                      //   try {
                      //     final response = await RiderRegsRepo()
                      //         .riderRegStatusMethod(userID!, context);
                      //     final status = response.data.status;
                      //     final riderId = response.data.id;

                      //     if (status.toLowerCase() == "pending") {
                      //       // ❌ NO StorageHelper here
                      //       // ✅ Fetch onboarding link directly
                      //       RiderPayoutRepo repo = RiderPayoutRepo();

                      //       final onboardingResponse = await repo
                      //           .regenerateOnboardingLink(
                      //             riderId,
                      //             'https://restaurantmanager.campuscravings.co/$riderId?verified=true',
                      //             'https://restaurantmanager.campuscravings.co/login',
                      //             context,
                      //           );

                      //       final onboardingUrl =
                      //           onboardingResponse?['data']['url'];

                      //       if (onboardingUrl != null &&
                      //           onboardingUrl.isNotEmpty) {
                      //         StripeView(context, ref, onboardingUrl, riderId);
                      //       } else if (response.message == "No Rider Found") {
                      //         context.pushRoute(StudentProfileDetailsRoute());
                      //       }
                      //     } else if (response.message == "No Rider Found") {
                      //       context.pushRoute(StudentProfileDetailsRoute());
                      //     }
                      //   } catch (e) {
                      //     // showToast(
                      //     //   context: context,
                      //     //   "Error occurred. Please try again.",
                      //     // );
                      //   }
                      // },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Register for Delivery',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}

void StripeView(
  BuildContext context,
  WidgetRef ref,
  String link,
  String id,
) async {
  String url = Uri.parse(link).toString();
  print("Opening Stripe URL: $url");

  String? result = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => StripeWebView(url)),
  );

  if (result == 'back_pressed') {
    print("User pressed back from Stripe WebView");

    final riderId = id;
    if (riderId != null) {
      showToast(context: context, "Refreshing...");
      RiderPayoutRepo repo = RiderPayoutRepo();

      final newData = await repo.regenerateOnboardingLink(
        riderId,
        'https://restaurantmanager.campuscravings.co/$riderId?verified=true',
        'https://restaurantmanager.campuscravings.co/login',
        context,
      );

      if (newData != null) {
        final newUrl = newData['data']['url'];
        // ✅ Store the new URL in the provider for the user to open later
        ref.read(paymentSetupProvider.notifier).state = {'url': newUrl};
        showToast(context: context, "Tap Stripe again to continue.");
      } else {
        showToast(context: context, "Failed to regenerate Stripe link.");
      }
    }
  }
}
