import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/base/baseviewmodel.dart';
import 'package:taxi_for_you/Features/other/car_aid_view/views/car_aid_view.dart';
import 'package:taxi_for_you/Features/other/freezers_view/freezers_view.dart';
import 'package:taxi_for_you/Features/other/goods_view/views/goods_view.dart';
import 'package:taxi_for_you/Features/other/water_tank_view/views/water_view.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/di.dart';
import 'package:taxi_for_you/core/utils/resources/assets_manager.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';
import 'package:taxi_for_you/data/model/user-model.dart';

import '../../../core/utils/resources/routes_manager.dart';
import '../../other/furniture_view/view/furniture_screen.dart';

class RequestServiceViewModel extends BaseViewModel {
  final AppPreferences appPreferences = instance<AppPreferences>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late List<ServiceTransportationModel> servicesList;
  late UserModel userModel;
  late BuildContext context;

  @override
  void start() {
    var user = appPreferences.getUserData();
    if (user == null) {
      appPreferences.logout(context);
    } else {
      userModel = user;
      servicesList = [
        ServiceTransportationModel(
          text: AppStrings.furnitureTransportation.tr(),
          imageAsset: ImageAssets.carFurniture,
          color: const Color.fromRGBO(255, 130, 110, 0.15),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FurnitureScreen(),
              settings: const RouteSettings(name: Routes.furnitureRoute),
            ),
          ),
        ),
        ServiceTransportationModel(
          text: AppStrings.goodsTransportation.tr(),
          imageAsset: ImageAssets.carGoods,
          color: const Color.fromRGBO(209, 133, 43, 0.15),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const GoodsView(),
              settings: const RouteSettings(name: Routes.goodsRoute),
            ),
          ),
        ),
        ServiceTransportationModel(
          text: AppStrings.carAidTransportation.tr(),
          imageAsset: ImageAssets.carAid,
          color: const Color.fromRGBO(150, 159, 170, 0.2),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CarAidView(),
              settings: const RouteSettings(name: Routes.carAidRoute),
            ),
          ),
        ),
        ServiceTransportationModel(
          text: AppStrings.freezerTransportation.tr(),
          imageAsset: ImageAssets.carfrozen,
          color: const Color.fromRGBO(150, 159, 170, 0.2),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FreezersView(),
              settings: const RouteSettings(name: Routes.freezerRoute),
            ),
          ),
        ),
        ServiceTransportationModel(
          text: AppStrings.waterTankTransportation.tr(),
          imageAsset: ImageAssets.carDrinkWater,
          color: const Color.fromRGBO(5, 75, 210, 0.1),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WaterTankView(),
              settings: const RouteSettings(name: Routes.waterTankRoute),
            ),
          ),
        ),
        ServiceTransportationModel(
          text: AppStrings.cisternsTransportation.tr(),
          imageAsset: ImageAssets.carCisterns,
          color: const Color.fromRGBO(44, 132, 143, 0.15),
          onPressed: () {},
        ),
      ];
    }
  }

  @override
  void dispose() {}
}

class ServiceTransportationModel {
  final String text;
  final String imageAsset;
  final Color color;
  final Function onPressed;

  ServiceTransportationModel({
    required this.text,
    required this.imageAsset,
    required this.color,
    required this.onPressed,
  });
}
