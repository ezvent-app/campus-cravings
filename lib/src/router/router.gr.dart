// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i30;
import 'package:campus_cravings/src/src.dart' as _i32;
import 'package:campus_cravings/src/ui/pages/add_payout/add_payout_page.dart'
    as _i1;
import 'package:campus_cravings/src/ui/pages/address_form/address_form_page.dart'
    as _i2;
import 'package:campus_cravings/src/ui/pages/auth/login/login_page.dart'
    as _i12;
import 'package:campus_cravings/src/ui/pages/auth/otp/otp_page.dart' as _i18;
import 'package:campus_cravings/src/ui/pages/auth/sign_up/sign_up_page.dart'
    as _i28;
import 'package:campus_cravings/src/ui/pages/checkout/checkout_page.dart'
    as _i7;
import 'package:campus_cravings/src/ui/pages/checkout/pages/chat_page/chat_page.dart'
    as _i4;
import 'package:campus_cravings/src/ui/pages/checkout/pages/check_out_address_page.dart'
    as _i6;
import 'package:campus_cravings/src/ui/pages/checkout/pages/deliver_to/deliver_to_page.dart'
    as _i8;
import 'package:campus_cravings/src/ui/pages/checkout/pages/delivering/delivering_page.dart'
    as _i9;
import 'package:campus_cravings/src/ui/pages/checkout/pages/map_order_tracking_page.dart'
    as _i5;
import 'package:campus_cravings/src/ui/pages/delivery_setup/delivery_setup_page.dart'
    as _i10;
import 'package:campus_cravings/src/ui/pages/main/main_page.dart' as _i13;
import 'package:campus_cravings/src/ui/pages/main/pages/change_password/change_password_page.dart'
    as _i3;
import 'package:campus_cravings/src/ui/pages/main/pages/notifications/notifications_page.dart'
    as _i15;
import 'package:campus_cravings/src/ui/pages/main/pages/placing_order/placing_order_page.dart'
    as _i20;
import 'package:campus_cravings/src/ui/pages/main/pages/product_details/product_details_page.dart'
    as _i21;
import 'package:campus_cravings/src/ui/pages/main/pages/promo_code/promo_code_page.dart'
    as _i24;
import 'package:campus_cravings/src/ui/pages/main/pages/restaurant/restaurant_page.dart'
    as _i25;
import 'package:campus_cravings/src/ui/pages/main/pages/saved_addresses/saved_addresses_page.dart'
    as _i26;
import 'package:campus_cravings/src/ui/pages/main/pages/settings/settings_page.dart'
    as _i27;
import 'package:campus_cravings/src/ui/pages/main/tabs/home/home_tab.dart'
    as _i11;
import 'package:campus_cravings/src/ui/pages/main/tabs/orders/orders_tab.dart'
    as _i17;
import 'package:campus_cravings/src/ui/pages/main/tabs/profile/profile_tab.dart'
    as _i23;
import 'package:campus_cravings/src/ui/pages/new_card/new_card_page.dart'
    as _i14;
import 'package:campus_cravings/src/ui/pages/onboarding/onboarding_page.dart'
    as _i16;
import 'package:campus_cravings/src/ui/pages/payment_methods/payment_methods_page.dart'
    as _i19;
import 'package:campus_cravings/src/ui/pages/profile_form/profile_form_page.dart'
    as _i22;
import 'package:campus_cravings/src/ui/pages/profile_form/student_profile_details_page.dart'
    as _i29;
import 'package:flutter/material.dart' as _i31;

/// generated route for
/// [_i1.AddPayoutPage]
class AddPayoutRoute extends _i30.PageRouteInfo<void> {
  const AddPayoutRoute({List<_i30.PageRouteInfo>? children})
    : super(AddPayoutRoute.name, initialChildren: children);

  static const String name = 'AddPayoutRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      return const _i1.AddPayoutPage();
    },
  );
}

/// generated route for
/// [_i2.AddressFormPage]
class AddressFormRoute extends _i30.PageRouteInfo<void> {
  const AddressFormRoute({List<_i30.PageRouteInfo>? children})
    : super(AddressFormRoute.name, initialChildren: children);

  static const String name = 'AddressFormRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      return const _i2.AddressFormPage();
    },
  );
}

/// generated route for
/// [_i3.ChangePasswordPage]
class ChangePasswordRoute extends _i30.PageRouteInfo<void> {
  const ChangePasswordRoute({List<_i30.PageRouteInfo>? children})
    : super(ChangePasswordRoute.name, initialChildren: children);

  static const String name = 'ChangePasswordRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      return const _i3.ChangePasswordPage();
    },
  );
}

/// generated route for
/// [_i4.CheckOutChatPage]
class CheckOutChatRoute extends _i30.PageRouteInfo<void> {
  const CheckOutChatRoute({List<_i30.PageRouteInfo>? children})
    : super(CheckOutChatRoute.name, initialChildren: children);

  static const String name = 'CheckOutChatRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      return const _i4.CheckOutChatPage();
    },
  );
}

/// generated route for
/// [_i5.CheckOutMapOrderTrackingPage]
class CheckOutMapOrderTrackingRoute
    extends _i30.PageRouteInfo<CheckOutMapOrderTrackingRouteArgs> {
  CheckOutMapOrderTrackingRoute({
    _i31.Key? key,
    List<_i30.PageRouteInfo>? children,
  }) : super(
         CheckOutMapOrderTrackingRoute.name,
         args: CheckOutMapOrderTrackingRouteArgs(key: key),
         initialChildren: children,
       );

  static const String name = 'CheckOutMapOrderTrackingRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CheckOutMapOrderTrackingRouteArgs>(
        orElse: () => const CheckOutMapOrderTrackingRouteArgs(),
      );
      return _i5.CheckOutMapOrderTrackingPage(key: args.key);
    },
  );
}

class CheckOutMapOrderTrackingRouteArgs {
  const CheckOutMapOrderTrackingRouteArgs({this.key});

  final _i31.Key? key;

  @override
  String toString() {
    return 'CheckOutMapOrderTrackingRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i6.CheckoutAddressPage]
class CheckoutAddressRoute extends _i30.PageRouteInfo<void> {
  const CheckoutAddressRoute({List<_i30.PageRouteInfo>? children})
    : super(CheckoutAddressRoute.name, initialChildren: children);

  static const String name = 'CheckoutAddressRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      return const _i6.CheckoutAddressPage();
    },
  );
}

/// generated route for
/// [_i7.CheckoutPage]
class CheckoutRoute extends _i30.PageRouteInfo<void> {
  const CheckoutRoute({List<_i30.PageRouteInfo>? children})
    : super(CheckoutRoute.name, initialChildren: children);

  static const String name = 'CheckoutRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      return const _i7.CheckoutPage();
    },
  );
}

/// generated route for
/// [_i8.DeliverToPage]
class DeliverToRoute extends _i30.PageRouteInfo<void> {
  const DeliverToRoute({List<_i30.PageRouteInfo>? children})
    : super(DeliverToRoute.name, initialChildren: children);

  static const String name = 'DeliverToRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      return const _i8.DeliverToPage();
    },
  );
}

/// generated route for
/// [_i9.DeliveringPage]
class DeliveringRoute extends _i30.PageRouteInfo<void> {
  const DeliveringRoute({List<_i30.PageRouteInfo>? children})
    : super(DeliveringRoute.name, initialChildren: children);

  static const String name = 'DeliveringRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      return const _i9.DeliveringPage();
    },
  );
}

/// generated route for
/// [_i10.DeliverySetupPage]
class DeliverySetupRoute extends _i30.PageRouteInfo<void> {
  const DeliverySetupRoute({List<_i30.PageRouteInfo>? children})
    : super(DeliverySetupRoute.name, initialChildren: children);

  static const String name = 'DeliverySetupRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      return const _i10.DeliverySetupPage();
    },
  );
}

/// generated route for
/// [_i11.HomeTabPage]
class HomeTabRoute extends _i30.PageRouteInfo<void> {
  const HomeTabRoute({List<_i30.PageRouteInfo>? children})
    : super(HomeTabRoute.name, initialChildren: children);

  static const String name = 'HomeTabRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      return const _i11.HomeTabPage();
    },
  );
}

/// generated route for
/// [_i12.LoginPage]
class LoginRoute extends _i30.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i32.Key? key, List<_i30.PageRouteInfo>? children})
    : super(
        LoginRoute.name,
        args: LoginRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'LoginRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginRouteArgs>(
        orElse: () => const LoginRouteArgs(),
      );
      return _i12.LoginPage(key: args.key);
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final _i32.Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i13.MainPage]
class MainRoute extends _i30.PageRouteInfo<void> {
  const MainRoute({List<_i30.PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      return const _i13.MainPage();
    },
  );
}

/// generated route for
/// [_i14.NewCardPage]
class NewCardRoute extends _i30.PageRouteInfo<void> {
  const NewCardRoute({List<_i30.PageRouteInfo>? children})
    : super(NewCardRoute.name, initialChildren: children);

  static const String name = 'NewCardRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      return const _i14.NewCardPage();
    },
  );
}

/// generated route for
/// [_i15.NotificationsPage]
class NotificationsRoute extends _i30.PageRouteInfo<void> {
  const NotificationsRoute({List<_i30.PageRouteInfo>? children})
    : super(NotificationsRoute.name, initialChildren: children);

  static const String name = 'NotificationsRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      return const _i15.NotificationsPage();
    },
  );
}

/// generated route for
/// [_i16.OnboardingPage]
class OnboardingRoute extends _i30.PageRouteInfo<void> {
  const OnboardingRoute({List<_i30.PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      return const _i16.OnboardingPage();
    },
  );
}

/// generated route for
/// [_i17.OrdersTabPage]
class OrdersTabRoute extends _i30.PageRouteInfo<void> {
  const OrdersTabRoute({List<_i30.PageRouteInfo>? children})
    : super(OrdersTabRoute.name, initialChildren: children);

  static const String name = 'OrdersTabRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      return const _i17.OrdersTabPage();
    },
  );
}

/// generated route for
/// [_i18.OtpPage]
class OtpRoute extends _i30.PageRouteInfo<void> {
  const OtpRoute({List<_i30.PageRouteInfo>? children})
    : super(OtpRoute.name, initialChildren: children);

  static const String name = 'OtpRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      return const _i18.OtpPage();
    },
  );
}

/// generated route for
/// [_i19.PaymentMethodsPage]
class PaymentMethodsRoute extends _i30.PageRouteInfo<PaymentMethodsRouteArgs> {
  PaymentMethodsRoute({
    _i32.Key? key,
    required bool fromCheckout,
    List<_i30.PageRouteInfo>? children,
  }) : super(
         PaymentMethodsRoute.name,
         args: PaymentMethodsRouteArgs(key: key, fromCheckout: fromCheckout),
         initialChildren: children,
       );

  static const String name = 'PaymentMethodsRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PaymentMethodsRouteArgs>();
      return _i19.PaymentMethodsPage(
        key: args.key,
        fromCheckout: args.fromCheckout,
      );
    },
  );
}

class PaymentMethodsRouteArgs {
  const PaymentMethodsRouteArgs({this.key, required this.fromCheckout});

  final _i32.Key? key;

  final bool fromCheckout;

  @override
  String toString() {
    return 'PaymentMethodsRouteArgs{key: $key, fromCheckout: $fromCheckout}';
  }
}

/// generated route for
/// [_i20.PlacingOrderPage]
class PlacingOrderRoute extends _i30.PageRouteInfo<void> {
  const PlacingOrderRoute({List<_i30.PageRouteInfo>? children})
    : super(PlacingOrderRoute.name, initialChildren: children);

  static const String name = 'PlacingOrderRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      return const _i20.PlacingOrderPage();
    },
  );
}

/// generated route for
/// [_i21.ProductDetailsPage]
class ProductDetailsRoute extends _i30.PageRouteInfo<ProductDetailsRouteArgs> {
  ProductDetailsRoute({
    _i32.Key? key,
    required _i32.Product product,
    List<_i30.PageRouteInfo>? children,
  }) : super(
         ProductDetailsRoute.name,
         args: ProductDetailsRouteArgs(key: key, product: product),
         initialChildren: children,
       );

  static const String name = 'ProductDetailsRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductDetailsRouteArgs>();
      return _i21.ProductDetailsPage(key: args.key, product: args.product);
    },
  );
}

class ProductDetailsRouteArgs {
  const ProductDetailsRouteArgs({this.key, required this.product});

  final _i32.Key? key;

  final _i32.Product product;

  @override
  String toString() {
    return 'ProductDetailsRouteArgs{key: $key, product: $product}';
  }
}

/// generated route for
/// [_i22.ProfileFormPage]
class ProfileFormRoute extends _i30.PageRouteInfo<ProfileFormRouteArgs> {
  ProfileFormRoute({
    _i32.Key? key,
    required bool newUser,
    List<_i30.PageRouteInfo>? children,
  }) : super(
         ProfileFormRoute.name,
         args: ProfileFormRouteArgs(key: key, newUser: newUser),
         initialChildren: children,
       );

  static const String name = 'ProfileFormRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProfileFormRouteArgs>();
      return _i22.ProfileFormPage(key: args.key, newUser: args.newUser);
    },
  );
}

class ProfileFormRouteArgs {
  const ProfileFormRouteArgs({this.key, required this.newUser});

  final _i32.Key? key;

  final bool newUser;

  @override
  String toString() {
    return 'ProfileFormRouteArgs{key: $key, newUser: $newUser}';
  }
}

/// generated route for
/// [_i23.ProfileTabPage]
class ProfileTabRoute extends _i30.PageRouteInfo<void> {
  const ProfileTabRoute({List<_i30.PageRouteInfo>? children})
    : super(ProfileTabRoute.name, initialChildren: children);

  static const String name = 'ProfileTabRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      return const _i23.ProfileTabPage();
    },
  );
}

/// generated route for
/// [_i24.PromoCodePage]
class PromoCodeRoute extends _i30.PageRouteInfo<void> {
  const PromoCodeRoute({List<_i30.PageRouteInfo>? children})
    : super(PromoCodeRoute.name, initialChildren: children);

  static const String name = 'PromoCodeRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      return const _i24.PromoCodePage();
    },
  );
}

/// generated route for
/// [_i25.RestaurantPage]
class RestaurantRoute extends _i30.PageRouteInfo<void> {
  const RestaurantRoute({List<_i30.PageRouteInfo>? children})
    : super(RestaurantRoute.name, initialChildren: children);

  static const String name = 'RestaurantRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      return const _i25.RestaurantPage();
    },
  );
}

/// generated route for
/// [_i26.SavedAddressesPage]
class SavedAddressesRoute extends _i30.PageRouteInfo<void> {
  const SavedAddressesRoute({List<_i30.PageRouteInfo>? children})
    : super(SavedAddressesRoute.name, initialChildren: children);

  static const String name = 'SavedAddressesRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      return const _i26.SavedAddressesPage();
    },
  );
}

/// generated route for
/// [_i27.SettingsPage]
class SettingsRoute extends _i30.PageRouteInfo<void> {
  const SettingsRoute({List<_i30.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      return const _i27.SettingsPage();
    },
  );
}

/// generated route for
/// [_i28.SignUpPage]
class SignUpRoute extends _i30.PageRouteInfo<SignUpRouteArgs> {
  SignUpRoute({_i32.Key? key, List<_i30.PageRouteInfo>? children})
    : super(
        SignUpRoute.name,
        args: SignUpRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'SignUpRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SignUpRouteArgs>(
        orElse: () => const SignUpRouteArgs(),
      );
      return _i28.SignUpPage(key: args.key);
    },
  );
}

class SignUpRouteArgs {
  const SignUpRouteArgs({this.key});

  final _i32.Key? key;

  @override
  String toString() {
    return 'SignUpRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i29.StudentProfileDetailsPage]
class StudentProfileDetailsRoute extends _i30.PageRouteInfo<void> {
  const StudentProfileDetailsRoute({List<_i30.PageRouteInfo>? children})
    : super(StudentProfileDetailsRoute.name, initialChildren: children);

  static const String name = 'StudentProfileDetailsRoute';

  static _i30.PageInfo page = _i30.PageInfo(
    name,
    builder: (data) {
      return const _i29.StudentProfileDetailsPage();
    },
  );
}
