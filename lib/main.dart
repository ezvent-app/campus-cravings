import 'package:campuscravings/src/di/dependency_injection.dart';
import 'package:campuscravings/src/src.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'src/constants/storageHelper.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageHelper.init();
  await SharePreferences.initPreferences();
  cameras = await availableCameras();
  DependencyInjection.initialize();
  Stripe.publishableKey =
      'pk_test_51MdYYoEO9c8tps039Vk4RHPQJxRx7i1OFLp0YRE49sZd0t3DrZOLtjysGYWOsMqHwUDhTzAhk1KLmyRhTiObHoqp00TM2S7rZ8';
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
