import 'package:campuscravings/src/src.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class PlaceOrderRepository {
  final HttpAPIServices _services = HttpAPIServices();

  final String secretKey =
      "";

  Map<String, dynamic>? paymentIntent;

  //CREATE ORDER API

  placeOrderMethod(Map<String, dynamic> json, BuildContext context) async {
    final res = await _services.postAPI(url: '/admin/order', map: json);
    final body = jsonDecode(res.body);
    if (res.statusCode == 200 || res.statusCode == 201) {
      printThis("Order created ${res.body}");
      if (context.mounted) {
        context.pushRoute(const CheckoutAddressRoute());
      }
    } else {
      if (context.mounted) {
        showToast(body['message'], context: context);
      }
    }
  }

  // Function to handle Stripe payment
  Future<void> makePayment({
    required String purchaseName,
    required String title,
    required double amountPaid,
    required String merchantDisplayName,
    required BuildContext context,
    required Function(String transactionId) onSuccess,
  }) async {
    try {
      // Create payment intent
      paymentIntent = await createPaymentIntent(
        (amountPaid * 100).toInt().toString(),
      );

      if (paymentIntent == null ||
          !paymentIntent!.containsKey("client_secret")) {
        throw Exception("Payment intent creation failed");
      }

      // Initialize payment sheet
      var gpay = const PaymentSheetGooglePay(
        merchantCountryCode: "US",
        currencyCode: "USD",
        testEnv: true,
      );

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!["client_secret"],
          style: ThemeMode.system,
          merchantDisplayName: merchantDisplayName,
          googlePay: gpay,
          appearance: PaymentSheetAppearance(
            primaryButton: PaymentSheetPrimaryButtonAppearance(
              colors: PaymentSheetPrimaryButtonTheme(
                dark: PaymentSheetPrimaryButtonThemeColors(
                  background: AppColors.primary,
                  text: Colors.white,
                ),
                light: PaymentSheetPrimaryButtonThemeColors(
                  background: AppColors.primary,
                  text: Colors.white,
                ),
              ),
            ),
          ),
        ),
      );

      // Present payment sheet
      await Stripe.instance.presentPaymentSheet();

      // If successful, handle onSuccess callback
      onSuccess(paymentIntent?["id"] ?? "unknown_transaction");
    } catch (e) {
      // Check if the exception is due to user cancellation
      if (e is StripeException && e.error.code == FailureCode.Canceled) {
        showToast(
          'You closed the payment sheet without completing the payment.',
          context: context,
        );
      } else {
        showToast(
          'An error occurred during payment. Please try again.',
          context: context,
        );

        print("Payment Error: $e");
      }
    }
  }

  // Function to create payment intent
  Future<Map<String, dynamic>?> createPaymentIntent(String amount) async {
    try {
      final response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        body: {"amount": amount, "currency": "USD"},
        headers: {
          "Authorization": "Bearer $secretKey",
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print("Stripe API Error: ${response.body}");
        return null;
      }
    } catch (e) {
      throw Exception("Failed to create payment intent: $e");
    }
  }
}
