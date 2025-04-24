import 'package:auto_route/auto_route.dart';
import 'package:campuscravings/src/constants/storageHelper.dart';
import 'package:campuscravings/src/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    await Future.delayed(const Duration(seconds: 3));

    final accessToken = StorageHelper().getAccessToken();
    print("My accessToken: $accessToken");
    if (accessToken != null) {
      context.replaceRoute(MainRoute());
    } else {
      context.replaceRoute(OnboardingRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SvgPicture.asset(
          'assets/images/svg/cclogo.svg',
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}
