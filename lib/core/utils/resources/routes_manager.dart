import 'package:flutter/material.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';
import 'package:taxi_for_you/Features/otp/view/verify_otp_screen.dart';
import '../../../Features/home_features/home/views/home_screen.dart';
import '../../../Features/registeration/views/registeration_screen.dart';
import '../../../app/di.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../Features/login/views/login_screen.dart';
import '../../../Features/splash/splash_view.dart';

class Routes {
  static const String splashRoute = "/";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String verifyOtpRoute = "/verifyOtp";
  static const String homeRoute = "/home";
  static const String otherRoute = "/other";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.homeRoute:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
          settings: const RouteSettings(name: Routes.homeRoute),
        );
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
          settings: const RouteSettings(name: Routes.loginRoute),
        );
      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(
          builder: (_) => RegistrationScreen(),
          settings: settings,
        );
      case Routes.verifyOtpRoute:
        initVerifyOtpModule();
        return MaterialPageRoute(
          builder: (_) => VerifyOtpScreen(),
          settings: settings,
        );
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text(AppStrings.noRouteFound.tr()),
              ),
              body: Center(child: Text(AppStrings.noRouteFound.tr())),
            ));
  }
}
