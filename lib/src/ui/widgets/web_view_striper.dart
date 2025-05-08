import 'package:campuscravings/src/constants/storageHelper.dart';
import 'package:campuscravings/src/src.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StripeWebView extends StatefulWidget {
  final String? url;

  const StripeWebView(this.url, {super.key});

  @override
  StripeWebViewState createState() => StripeWebViewState();
}

class StripeWebViewState extends State<StripeWebView> {
  late WebViewController controller;

  @override
  void initState() {
    initWebView();
    super.initState();
  }

  Future clearCookies() async {
    final WebViewCookieManager cookieManager = WebViewCookieManager();
    await cookieManager.clearCookies();
  }

  initWebView() async {
    controller = WebViewController.fromPlatformCreationParams(
      const PlatformWebViewControllerCreationParams(),
    );
    await clearCookies();
    controller
      ..setUserAgent(
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
        '(KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36',
      )
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            print('Web resource error: $error');
          },
          onNavigationRequest: (NavigationRequest request) {
            RiderPayoutRepo repo = RiderPayoutRepo();
            String? userId = StorageHelper().getRiderId();

            if (request.url.startsWith(
              'http://restaurantmanager.campuscravings.co/$userId?verified=true',
            )) {
              // Call API
              repo
                  .changeUserStatus(userId!)
                  .then((_) {
                    context.router.replaceAll([MainRoute()]);
                  })
                  .catchError((e) {
                    print('Failed to change user status: $e');
                  });

              return NavigationDecision.prevent;
            }
            // Failure Case
            if (request.url ==
                'http://restaurantmanager.campuscravings.co/login') {
              print('Stripe onboarding failed or cancelled.');
              Navigator.of(context).pop(); // Close the WebView
              showToast(
                context: context,
                "Stripe onboarding failed or cancelled.",
              );
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      );

    controller
        .loadRequest(
          Uri.parse(widget.url!),
          headers: {
            'Cache-Control': 'no-cache',
            'Pragma': 'no-cache',
            'Expires': '0',
          },
        )
        .then((value) {
          print('Request loaded');
          controller.clearCache();
          print('Cache cleared');
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Setup Stripe Account'),
        backgroundColor: Colors.white,
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
