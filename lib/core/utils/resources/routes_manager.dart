import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/home/views/home_screen.dart';
import 'package:taxi_for_you/Features/transportation_requests/cisterns_view/views/cisterns_view.dart';
import 'package:taxi_for_you/Features/trip_details/view/trip_details_screen.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';
import 'package:taxi_for_you/Features/otp/view/verify_otp_screen.dart';
import '../../../Features/transportation_requests/car_aid_view/views/car_aid_view.dart';
import '../../../Features/transportation_requests/freezers_view/view/freezers_view.dart';
import '../../../Features/transportation_requests/furniture_view/view/furniture_screen.dart';
import '../../../Features/transportation_requests/goods_view/views/goods_view.dart';
import '../../../Features/transportation_requests/water_tank_view/views/water_view.dart';
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
  static const String furnitureRoute = "/furniture";
  static const String goodsRoute = "/goods";
  static const String freezerRoute = "/freezers";
  static const String carAidRoute = "/carAid";
  static const String waterTankRoute = "/waterTank";
  static const String cisternsRoute = "/cisterns";
  static const String tripDetailsRoute = "/trip-details";
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
      case Routes.goodsRoute:
        return MaterialPageRoute(builder: (_) => const GoodsView());
      case Routes.furnitureRoute:
        return MaterialPageRoute(builder: (_) => const FurnitureScreen());
      case Routes.carAidRoute:
        return MaterialPageRoute(builder: (_) => const CarAidView());
      case Routes.waterTankRoute:
        return MaterialPageRoute(builder: (_) => const WaterTankView());
      case Routes.cisternsRoute:
        return MaterialPageRoute(builder: (_) => const CisternsView());
      case Routes.freezerRoute:
        return MaterialPageRoute(builder: (_) => const FreezersView());
      case Routes.tripDetailsRoute:
        return MaterialPageRoute(builder: (_) => const TripDetailsScreen());
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
