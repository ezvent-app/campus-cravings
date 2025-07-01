import 'package:campuscravings/src/di/dependency_injection.dart';
import 'package:campuscravings/src/src.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'src/constants/storageHelper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageHelper.init();
  await SharePreferences.initPreferences();
  DependencyInjection.initialize();
  //for test environment
  Stripe.publishableKey =
      'pk_test_51QrMKeKniJk5EBZPSfsTDIs4KX8BM5zOCVqH0qijocvmzk0C2N5UTZvRevsdnryUVAkGY0dZULjvZ7TCApAAy26R00AJ2DVGXS';
  //for live environment
  //  Stripe.publishableKey =
  // 'pk_live_51QrMKeKniJk5EBZPWIp7c11h5UimgnhRuvVuqM3FZt3qGv3F0YuDcILNB5T1jM6shYaSeR0ltgW8ftyyv9L7ayqi00QCHZHGxb';
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        title: "Campus Cravings",
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: lightTheme,
        routerConfig: _appRouter.config(),
      ),
    );
  }
}
