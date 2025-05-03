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
      ..setUserAgent('random')
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
            if (request.url.startsWith('https://example.com/callback')) {
              print('Redirect URL: ${request.url}');
              Navigator.pop(context, request.url);
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
