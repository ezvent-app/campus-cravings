import 'package:campuscravings/src/constants/storageHelper.dart';
import 'package:campuscravings/src/src.dart';
import 'package:campuscravings/src/ui/widgets/web_view_striper.dart';

@RoutePage()
class AddPayoutPage extends ConsumerStatefulWidget {
  final String url;
  const AddPayoutPage({super.key, required this.url});

  @override
  ConsumerState createState() => _AddPayoutPageState();
}

class _AddPayoutPageState extends ConsumerState<AddPayoutPage> {
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale.addPayoutDetails,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeExtraLarge,
          vertical: 8,
        ),
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  child: SvgPicture.asset(
                    'assets/images/svg/cclogo.svg',
                    width: 40,
                    height: 40,
                  ),
                ),
                width(8),
                Text(
                  locale.campusCravings,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            Text(
              locale.paymentMethod,
              style: Theme.of(context).textTheme.titleLarge,
            ),

            Text(
              locale.connectToStripe,
              style: Theme.of(context).textTheme.bodySmall,
            ),

            Consumer(
              builder: (context, ref, child) {
                // String? riderId = StorageHelper().getRiderId();
                final payout = ref.watch(paymentSetupProvider);
                return RoundedButtonWidget(
                  isLoading: _isLoading,
                  btnTitle: locale.stripe,
                  onTap: () async {
                    setState(() => _isLoading = true);

                    final payout = ref.read(paymentSetupProvider);
                    final url = payout['url'] ?? widget.url;

                    if (url != null && url.isNotEmpty) {
                      openStripeView(context, ref, url); // Pass ref here ✅
                    } else {
                      showToast(context: context, "Invalid Stripe link.");
                    }

                    setState(() => _isLoading = false);
                  },
                );
              },
            ),
            height(40),
          ],
        ),
      ),
    );
  }
}

final paymentSetupProvider = StateProvider<Map<String, dynamic>>((ref) => {});

void openStripeView(BuildContext context, WidgetRef ref, String link) async {
  String url = Uri.parse(link).toString();
  print("Opening Stripe URL: $url");

  String? result = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => StripeWebView(url)),
  );

  if (result == 'back_pressed') {
    print("User pressed back from Stripe WebView");

    final riderId = StorageHelper().getRiderId();
    if (riderId != null) {
      showToast(context: context, "Refreshing...");
      RiderPayoutRepo repo = RiderPayoutRepo();

      final newData = await repo.generateOnboardingLink(
        riderId,
        'http://restaurantmanager.campuscravings.co/$riderId?verified=true',
        'http://restaurantmanager.campuscravings.co/login',
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
