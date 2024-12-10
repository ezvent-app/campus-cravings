// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:campus_cravings/models/product/product.dart' as _i13;
import 'package:campus_cravings/ui/pages/login/login_page.dart' as _i2;
import 'package:campus_cravings/ui/pages/main/main_page.dart' as _i3;
import 'package:campus_cravings/ui/pages/main/pages/product_details/product_details_page.dart'
    as _i7;
import 'package:campus_cravings/ui/pages/main/pages/restaurant/restaurant_page.dart'
    as _i9;
import 'package:campus_cravings/ui/pages/main/tabs/home/home_tab.dart' as _i1;
import 'package:campus_cravings/ui/pages/main/tabs/orders/orders_tab.dart'
    as _i5;
import 'package:campus_cravings/ui/pages/main/tabs/profile/profile_tab.dart'
    as _i8;
import 'package:campus_cravings/ui/pages/onboarding/onboarding_page.dart'
    as _i4;
import 'package:campus_cravings/ui/pages/otp/otp_page.dart' as _i6;
import 'package:campus_cravings/ui/pages/sign_up/sign_up_page.dart' as _i10;
import 'package:flutter/material.dart' as _i12;

/// generated route for
/// [_i1.HomeTab]
class HomeTab extends _i11.PageRouteInfo<void> {
  const HomeTab({List<_i11.PageRouteInfo>? children})
      : super(
          HomeTab.name,
          initialChildren: children,
        );

  static const String name = 'HomeTab';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i1.HomeTab();
    },
  );
}

/// generated route for
/// [_i2.LoginPage]
class LoginRoute extends _i11.PageRouteInfo<void> {
  const LoginRoute({List<_i11.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i2.LoginPage();
    },
  );
}

/// generated route for
/// [_i3.MainPage]
class MainRoute extends _i11.PageRouteInfo<void> {
  const MainRoute({List<_i11.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i3.MainPage();
    },
  );
}

/// generated route for
/// [_i4.OnboardingPage]
class OnboardingRoute extends _i11.PageRouteInfo<void> {
  const OnboardingRoute({List<_i11.PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i4.OnboardingPage();
    },
  );
}

/// generated route for
/// [_i5.OrdersTab]
class OrdersTab extends _i11.PageRouteInfo<void> {
  const OrdersTab({List<_i11.PageRouteInfo>? children})
      : super(
          OrdersTab.name,
          initialChildren: children,
        );

  static const String name = 'OrdersTab';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i5.OrdersTab();
    },
  );
}

/// generated route for
/// [_i6.OtpPage]
class OtpRoute extends _i11.PageRouteInfo<void> {
  const OtpRoute({List<_i11.PageRouteInfo>? children})
      : super(
          OtpRoute.name,
          initialChildren: children,
        );

  static const String name = 'OtpRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i6.OtpPage();
    },
  );
}

/// generated route for
/// [_i7.ProductDetailsPage]
class ProductDetailsRoute extends _i11.PageRouteInfo<ProductDetailsRouteArgs> {
  ProductDetailsRoute({
    _i12.Key? key,
    required _i13.Product product,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          ProductDetailsRoute.name,
          args: ProductDetailsRouteArgs(
            key: key,
            product: product,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductDetailsRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductDetailsRouteArgs>();
      return _i7.ProductDetailsPage(
        key: args.key,
        product: args.product,
      );
    },
  );
}

class ProductDetailsRouteArgs {
  const ProductDetailsRouteArgs({
    this.key,
    required this.product,
  });

  final _i12.Key? key;

  final _i13.Product product;

  @override
  String toString() {
    return 'ProductDetailsRouteArgs{key: $key, product: $product}';
  }
}

/// generated route for
/// [_i8.ProfileTab]
class ProfileTab extends _i11.PageRouteInfo<void> {
  const ProfileTab({List<_i11.PageRouteInfo>? children})
      : super(
          ProfileTab.name,
          initialChildren: children,
        );

  static const String name = 'ProfileTab';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i8.ProfileTab();
    },
  );
}

/// generated route for
/// [_i9.RestaurantPage]
class RestaurantRoute extends _i11.PageRouteInfo<void> {
  const RestaurantRoute({List<_i11.PageRouteInfo>? children})
      : super(
          RestaurantRoute.name,
          initialChildren: children,
        );

  static const String name = 'RestaurantRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i9.RestaurantPage();
    },
  );
}

/// generated route for
/// [_i10.SignUpPage]
class SignUpRoute extends _i11.PageRouteInfo<void> {
  const SignUpRoute({List<_i11.PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i10.SignUpPage();
    },
  );
}
