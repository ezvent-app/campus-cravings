import 'package:campuscravings/src/src.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  // final routeGuards = [AuthGuard()];

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashScreen.page, path: '/', initial: true),
    AutoRoute(page: OnboardingRoute.page, path: '/onboarding'),
    AutoRoute(page: LoginRoute.page, path: '/login'),
    AutoRoute(page: ForgetPasswordRoute.page, path: '/forget_password'),
    AutoRoute(page: ForgetPasswordOTPRoute.page, path: '/forget_password_OTP'),
    AutoRoute(page: NewPasswordRoute.page, path: '/new_password'),
    AutoRoute(page: SignUpRoute.page, path: '/sign-up'),
    AutoRoute(page: OtpRoute.page, path: '/otp'),
    AutoRoute(
      page: StudentProfileDetailsRoute.page,
      path: '/stdProfileDetails',
    ),
    AutoRoute(
      page: MainRoute.page,
      path: '/main',
      children: [
        AutoRoute(page: HomeTabRoute.page, path: ''),
        AutoRoute(page: OrdersTabRoute.page, path: 'orders'),
        AutoRoute(page: CartTabRoute.page, path: 'cart_tab'),
        AutoRoute(page: RidersTabRoute.page, path: 'riders'),
        AutoRoute(page: ProfileTabRoute.page, path: 'profile'),
        AutoRoute(
          page: DeliveryRegistrationRoute.page,
          path: 'delivery_registration',
        ),
      ],
    ),
    AutoRoute(page: ProductDetailsRoute.page, path: '/product-details'),
    AutoRoute(page: RestaurantRoute.page, path: '/restaurant'),
    AutoRoute(page: CheckOutChatRoute.page, path: '/checkout_chat_page'),
    AutoRoute(
      page: DeliveryManProfileRoute.page,
      path: '/delivery_man_profile_page',
    ),
    AutoRoute(page: CheckoutAddressRoute.page, path: '/check_out_address-page'),
    AutoRoute(
      page: CheckOutMapOrderTrackingRoute.page,
      path: '/check_out_map_order_tracking-page',
    ),
    AutoRoute(page: AddressFormRoute.page, path: '/address-form'),
    AutoRoute(page: PaymentMethodsRoute.page, path: '/payment-methods'),
    AutoRoute(page: NewCardRoute.page, path: '/new-card'),
    AutoRoute(page: ProfileFormRoute.page, path: '/profile_form'),
    AutoRoute(page: DeliverySetupRoute.page, path: '/delivery-setup'),
    AutoRoute(page: CheckOutAddNewAddressRoute.page, path: '/add_new-address'),
    AutoRoute(page: HelpFAQRoute.page, path: '/help-order'),
    AutoRoute(page: ChangeLanguageRoute.page, path: '/change-language'),
    AutoRoute(page: HelpRoute.page, path: '/help'),
    AutoRoute(page: ContactSupportRoute.page, path: '/contact-support'),
    AutoRoute(page: AddPayoutRoute.page, path: '/add-payout'),
    AutoRoute(page: SavedAddressesRoute.page, path: '/saved-addresses'),
    AutoRoute(page: PromoCodeRoute.page, path: '/promo-code'),
    AutoRoute(page: NotificationsRoute.page, path: '/notifications'),
    AutoRoute(page: ChangePasswordRoute.page, path: '/change-password'),
    AutoRoute(page: PlacingOrderRoute.page, path: '/placing-order'),
    AutoRoute(page: DeliveringRoute.page, path: '/delivering'),
    AutoRoute(page: CheckOutTabRoute.page, path: '/check_out'),
    AutoRoute(page: RaiseTicketRoute.page, path: '/raise_ticket'),
    AutoRoute(page: TicketMessagesRoute.page, path: '/ticket_messages'),
  ];
}
