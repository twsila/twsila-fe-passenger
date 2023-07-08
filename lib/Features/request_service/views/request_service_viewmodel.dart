import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/base/baseviewmodel.dart';
import 'package:taxi_for_you/Features/common/state_renderer/dialogs.dart';
import 'package:taxi_for_you/Features/transportation_requests/model/transportation_base_model.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/furniture/models/furniture_model.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/goods/models/goods_model.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/constants.dart';
import 'package:taxi_for_you/app/di.dart';
import 'package:taxi_for_you/core/utils/resources/assets_manager.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';
import 'package:taxi_for_you/data/model/user-model.dart';
import 'package:collection/collection.dart';

import '../../transportation_requests/view/transport_request_view.dart';
import '../../transportation_requests/view/widgets/transportation_widgets/car_aid/models/car-aid-model.dart';
import '../../transportation_requests/view/widgets/transportation_widgets/cisterns/models/cisterns_model.dart';
import '../../transportation_requests/view/widgets/transportation_widgets/freezers/models/freezers-model.dart';
import '../../transportation_requests/view/widgets/transportation_widgets/water_tank/models/water_model.dart';

class RequestServiceViewModel extends BaseViewModel {
  final AppPreferences appPreferences = instance<AppPreferences>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late List<ServiceTransportationModel> servicesList;
  late UserModel userModel;
  late BuildContext context;
  bool isInit = true;
  List<TransportationBaseModel> oldTrips = [];

  getOldTrips() {
    oldTrips = appPreferences.getTrips();
  }

  bool checkOldTrips(String endPoint) {
    return (oldTrips
            .singleWhereOrNull((trip) => trip.tripEndPoint == endPoint)) ==
        null;
  }

  @override
  void start() {
    appPreferences.removeTrips();
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
          onPressed: () =>
              checkOldTrips(EndPointsConstants.sendFurnitureRequest)
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransportRequestScreen(
                          transportationBaseModel: FurnitureModel(),
                          icon: ImageAssets.carFurniture,
                          title: AppStrings.furnitureTransportation.tr(),
                        ),
                      ),
                    )
                  : ShowDialogHelper.showErrorMessage(
                      AppStrings.oldRequest.tr(), context),
        ),
        ServiceTransportationModel(
          text: AppStrings.goodsTransportation.tr(),
          imageAsset: ImageAssets.carGoods,
          color: const Color.fromRGBO(209, 133, 43, 0.15),
          onPressed: () => checkOldTrips(EndPointsConstants.sendGoodsRequest)
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TransportRequestScreen(
                      transportationBaseModel: GoodsModel(),
                      icon: ImageAssets.carGoods,
                      title: AppStrings.goodsTransportation.tr(),
                    ),
                  ),
                )
              : ShowDialogHelper.showErrorMessage(
                  AppStrings.oldRequest.tr(), context),
        ),
        ServiceTransportationModel(
          text: AppStrings.carAidTransportation.tr(),
          imageAsset: ImageAssets.carAid,
          color: const Color.fromRGBO(150, 159, 170, 0.2),
          onPressed: () => checkOldTrips(EndPointsConstants.sendCarAidRequest)
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TransportRequestScreen(
                      transportationBaseModel: CarAidModel(),
                      hasImages: false,
                      icon: ImageAssets.carAid,
                      title: AppStrings.request.tr() +
                          ' ' +
                          AppStrings.carAidTransportation.tr(),
                    ),
                  ),
                )
              : ShowDialogHelper.showErrorMessage(
                  AppStrings.oldRequest.tr(), context),
        ),
        ServiceTransportationModel(
          text: AppStrings.freezerTransportation.tr(),
          imageAsset: ImageAssets.carfrozen,
          color: const Color.fromRGBO(180, 221, 127, 0.2),
          onPressed: () => checkOldTrips(EndPointsConstants.sendFreezersRequest)
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TransportRequestScreen(
                      transportationBaseModel: FreezersModel(),
                      icon: ImageAssets.carfrozen,
                      title: AppStrings.freezerTransportation.tr(),
                    ),
                  ),
                )
              : ShowDialogHelper.showErrorMessage(
                  AppStrings.oldRequest.tr(), context),
        ),
        ServiceTransportationModel(
          text: AppStrings.waterTankTransportation.tr(),
          imageAsset: ImageAssets.carDrinkWater,
          color: const Color.fromRGBO(5, 75, 210, 0.1),
          onPressed: () => checkOldTrips(EndPointsConstants.sendWaterRequest)
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TransportRequestScreen(
                      hasImages: false,
                      icon: ImageAssets.carDrinkWater,
                      transportationBaseModel: WaterModel(),
                      title: AppStrings.requestWhite.tr() +
                          ' ' +
                          AppStrings.waterTankTransportation.tr(),
                    ),
                  ),
                )
              : ShowDialogHelper.showErrorMessage(
                  AppStrings.oldRequest.tr(), context),
        ),
        ServiceTransportationModel(
          text: AppStrings.cisternsTransportation.tr(),
          imageAsset: ImageAssets.carCisterns,
          color: const Color.fromRGBO(44, 132, 143, 0.15),
          onPressed: () => checkOldTrips(EndPointsConstants.sendCisternsRequest)
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TransportRequestScreen(
                      transportationBaseModel: CisternsModel(),
                      icon: ImageAssets.carCisterns,
                      title: AppStrings.request.tr() +
                          ' ' +
                          AppStrings.cisternsTransportation.tr(),
                    ),
                  ),
                )
              : ShowDialogHelper.showErrorMessage(
                  AppStrings.oldRequest.tr(), context),
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
