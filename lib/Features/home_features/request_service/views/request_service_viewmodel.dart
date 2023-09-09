import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_for_you/Features/base/baseviewmodel.dart';
import 'package:taxi_for_you/Features/home_features/request_service/bloc/draft_trip_bloc.dart';
import 'package:taxi_for_you/Features/home_features/request_service/bloc/draft_trip_event.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/furniture/models/furniture_model.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/goods/models/goods_model.dart';
import 'package:taxi_for_you/Features/trip_details/model/trip_details_model.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/constants.dart';
import 'package:taxi_for_you/app/di.dart';
import 'package:taxi_for_you/core/utils/resources/assets_manager.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';
import 'package:taxi_for_you/data/model/user-model.dart';

import '../../../transportation_requests/view/transport_request_view.dart';
import '../../../transportation_requests/view/widgets/transportation_widgets/car_aid/models/car-aid-model.dart';
import '../../../transportation_requests/view/widgets/transportation_widgets/cisterns/models/cisterns_model.dart';
import '../../../transportation_requests/view/widgets/transportation_widgets/freezers/models/freezers-model.dart';
import '../../../transportation_requests/view/widgets/transportation_widgets/water_tank/models/water_model.dart';

class RequestServiceViewModel extends BaseViewModel {
  final AppPreferences appPreferences = instance<AppPreferences>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late List<ServiceTransportationModel> servicesList;
  late UserModel userModel;
  late BuildContext context;
  TripDetailsModel? draftTrip;

  @override
  void start() {
    // appPreferences.removeTrips();
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
          onPressed: () {
            FurnitureModel furnitureModel = FurnitureModel();
            furnitureModel.tripType = TripTypeConstants.furnitureType;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TransportRequestScreen(
                  transportationBaseModel: furnitureModel,
                ),
              ),
            );
          },
        ),
        ServiceTransportationModel(
          text: AppStrings.goodsTransportation.tr(),
          imageAsset: ImageAssets.carGoods,
          color: const Color.fromRGBO(209, 133, 43, 0.15),
          onPressed: () {
            GoodsModel goodsModel = GoodsModel();
            goodsModel.tripType = TripTypeConstants.goodsType;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TransportRequestScreen(
                  transportationBaseModel: goodsModel,
                ),
              ),
            );
          },
        ),
        ServiceTransportationModel(
          text: AppStrings.carAidTransportation.tr(),
          imageAsset: ImageAssets.carAid,
          color: const Color.fromRGBO(150, 159, 170, 0.2),
          onPressed: () {
            CarAidModel carAidModel = CarAidModel();
            carAidModel.tripType = TripTypeConstants.carAidType;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TransportRequestScreen(
                  transportationBaseModel: carAidModel,
                  hasImages: false,
                ),
              ),
            );
          },
        ),
        ServiceTransportationModel(
          text: AppStrings.freezerTransportation.tr(),
          imageAsset: ImageAssets.carfrozen,
          color: const Color.fromRGBO(180, 221, 127, 0.2),
          onPressed: () {
            FreezersModel freezersModel = FreezersModel();
            freezersModel.tripType = TripTypeConstants.frozenType;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TransportRequestScreen(
                  transportationBaseModel: freezersModel,
                ),
              ),
            );
          },
        ),
        ServiceTransportationModel(
          text: AppStrings.waterTankTransportation.tr(),
          imageAsset: ImageAssets.carDrinkWater,
          color: const Color.fromRGBO(5, 75, 210, 0.1),
          onPressed: () {
            WaterModel waterModel = WaterModel();
            waterModel.tripType = TripTypeConstants.drinkWaterType;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TransportRequestScreen(
                  hasImages: false,
                  hasSourceLocation: false,
                  transportationBaseModel: waterModel,
                ),
              ),
            );
          },
        ),
        ServiceTransportationModel(
          text: AppStrings.cisternsTransportation.tr(),
          imageAsset: ImageAssets.carCisterns,
          color: const Color.fromRGBO(44, 132, 143, 0.15),
          onPressed: () {
            CisternsModel cisternsModel = CisternsModel();
            cisternsModel.tripType = TripTypeConstants.otherTankType;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TransportRequestScreen(
                  transportationBaseModel: cisternsModel,
                  hasImages: false,
                  hasSourceLocation: false,
                ),
              ),
            );
          },
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
