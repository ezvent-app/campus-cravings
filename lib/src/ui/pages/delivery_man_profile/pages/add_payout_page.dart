import 'package:campuscravings/src/constants/storageHelper.dart';
import 'package:campuscravings/src/src.dart';
import 'package:campuscravings/src/ui/widgets/web_view_striper.dart';

@RoutePage()
class AddPayoutPage extends ConsumerStatefulWidget {
  const AddPayoutPage({super.key});

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
                    // RiderPayoutRepo repo = RiderPayoutRepo();
                    // repo.generateOnboardingLink(riderId!);

                    setState(() {
                      _isLoading = true;
                    });

                    final String? paymentLink =
                        StorageHelper().getPyemntGenUrl();
                    if (paymentLink != null) {
                      openStripeView(context);

                      setState(() {
                        _isLoading = false;
                      });
                      // context.router.replaceAll([MainRoute()]);
                    } else {}

                    ref.read(paymentSetupProvider.notifier).state = {};
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

void openStripeView(BuildContext context) async {
  final link = StorageHelper().getPyemntGenUrl();
  String buildUrl() {
    String baseUrl = link!;
    final Uri uri = Uri.parse(baseUrl);
    return uri.toString();
  }

  String url = buildUrl();
  print("URL: $url");
  String? result = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => StripeWebView(url)),
  );

  if (result != null) {
    print("Success! Callback URL: $result");
  } else {
    print("WebView closed without callback.");
  }
}
