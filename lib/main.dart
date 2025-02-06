import 'src/src.dart';

void main() {
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
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'SofiaPro',
          colorScheme: const ColorScheme.light(primary: AppColors.primary)
              .copyWith(surface: AppColors.background),
        ),
        routerConfig: _appRouter.config(),
      ),
    );
  }
}
