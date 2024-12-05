import 'package:auto_route/auto_route.dart';
import 'package:campus_cravings/router/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  // final routeGuards = [AuthGuard()];

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: OnboardingRoute.page,
      path: '/',
    ),
    AutoRoute(
      page: LoginRoute.page,
      path: '/login',
    ),
    AutoRoute(
      page: SignUpRoute.page,
      path: '/sign-up',
    ),
    AutoRoute(
      page: OtpRoute.page,
      path: '/otp',
    ),
    AutoRoute(
      page: MainRoute.page,
      path: '/main',
      children: [
        AutoRoute(
          page: HomeTab.page,
          path: '',
        ),
        AutoRoute(
          page: OrdersTab.page,
          path: 'orders',
        ),
        AutoRoute(
          page: ProfileTab.page,
          path: 'profile',
        ),
      ]
    ),
  ];
}