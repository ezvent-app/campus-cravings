import 'package:campus_cravings/constants/app_colors.dart';
import 'package:campus_cravings/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});
  final _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        title: "Instant Scraper",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'SofiaPro',
          colorScheme: const ColorScheme.light(primary: AppColors.primary).copyWith(surface: AppColors.background),
        ),
        routerConfig: _appRouter.config(),
      ),
    );
  }
}