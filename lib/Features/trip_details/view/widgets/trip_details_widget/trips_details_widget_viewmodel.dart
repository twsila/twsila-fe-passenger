import 'package:easy_localization/easy_localization.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/constants.dart';
import 'package:taxi_for_you/app/di.dart';
import 'package:taxi_for_you/core/utils/resources/assets_manager.dart';

import '../../../../../core/utils/resources/strings_manager.dart';

class TripsDetailsWidgetViewModel {
  final AppPreferences appPreferences = instance();

  String getIconName(String tripType) {
    switch (tripType) {
      case TripTypeConstants.furnitureType:
        return ImageAssets.carFurniture;
      case TripTypeConstants.frozenType:
        return ImageAssets.carfrozen;
      case TripTypeConstants.goodsType:
        return ImageAssets.carGoods;
      case TripTypeConstants.carAidType:
        return ImageAssets.carAid;
      case TripTypeConstants.otherTankType:
        return ImageAssets.carCisterns;
      case TripTypeConstants.drinkWaterType:
        return ImageAssets.carDrinkWater;
      default:
        return ImageAssets.carFurniture;
    }
  }

  String getTitle(String tripType) {
    switch (tripType) {
      case TripTypeConstants.furnitureType:
        return AppStrings.request.tr() +
            ' ' +
            AppStrings.furnitureTransportation.tr();
      case TripTypeConstants.frozenType:
        return AppStrings.request.tr() +
            ' ' +
            AppStrings.freezerTransportation.tr();
      case TripTypeConstants.goodsType:
        return AppStrings.request.tr() +
            ' ' +
            AppStrings.goodsTransportation.tr();
      case TripTypeConstants.carAidType:
        return AppStrings.request.tr() +
            ' ' +
            AppStrings.carAidTransportation.tr();
      case TripTypeConstants.otherTankType:
        return AppStrings.request.tr() +
            ' ' +
            AppStrings.cisternsTransportation.tr();
      case TripTypeConstants.drinkWaterType:
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
