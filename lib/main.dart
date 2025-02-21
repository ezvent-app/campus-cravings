import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:campus_cravings/src/src.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
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
        builder: (context, child) {
          return DevicePreview(
            enabled: !kReleaseMode,
            builder: (context) {
              return child!;
            },
          );
        },
      ),
    );
  }
}
