import 'package:easy_localization/easy_localization.dart';
import 'package:taxi_for_you/core/utils/resources/assets_manager.dart';
import 'package:taxi_for_you/data/model/trip_type.dart';

import '../../../../../core/utils/resources/strings_manager.dart';

class TripsDetailsWidgetViewModel {
  late TripType tripType;

  setTripType(TripType tripType) {
    this.tripType = tripType;
  }

  String getIconName() {
    switch (tripType) {
      case TripType.furniture:
        return ImageAssets.carFurniture;
      case TripType.freezers:
        return ImageAssets.carfrozen;
      case TripType.goods:
        return ImageAssets.carGoods;
      case TripType.carAid:
        return ImageAssets.carAid;
      case TripType.cisterns:
        return ImageAssets.carCisterns;
      case TripType.waterTank:
        return ImageAssets.carDrinkWater;
      default:
        return ImageAssets.carFurniture;
    }
  }

  String getTitle() {
    switch (tripType) {
      case TripType.furniture:
        return AppStrings.request.tr() +
            ' ' +
            AppStrings.furnitureTransportation.tr();
      case TripType.freezers:
        return AppStrings.request.tr() +
            ' ' +
            AppStrings.freezerTransportation.tr();
      case TripType.goods:
        return AppStrings.request.tr() +
            ' ' +
            AppStrings.goodsTransportation.tr();
      case TripType.carAid:
        return AppStrings.request.tr() +
            ' ' +
            AppStrings.carAidTransportation.tr();
      case TripType.cisterns:
        return AppStrings.request.tr() +
            ' ' +
            AppStrings.cisternsTransportation.tr();
      case TripType.waterTank:
        return AppStrings.requestWhite.tr() +
            ' ' +
            AppStrings.waterTankTransportation.tr();
      default:
        return AppStrings.request.tr() +
            ' ' +
            AppStrings.furnitureTransportation.tr();
    }
  }
}
