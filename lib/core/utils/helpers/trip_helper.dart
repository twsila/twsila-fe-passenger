import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:taxi_for_you/Features/transportation_requests/model/transportation_base_model.dart';
import 'package:taxi_for_you/core/utils/helpers/date_helper.dart';

import '../../../app/constants.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/strings_manager.dart';

class TripHelper {
  static String getTripText(TransportationBaseModel transportationBaseModel) {
    //SUBMITTED OR EVALUATION
    if (transportationBaseModel.tripStatus == TripStatusConstants.submitted ||
        transportationBaseModel.tripStatus == TripStatusConstants.evaluation) {
      return AppStrings.tripStatusSUBMITTEDorEVALUATED.tr();
    }
    //PAYMENT
    else if (transportationBaseModel.tripStatus ==
        TripStatusConstants.payment) {
      return AppStrings.tripStatusPAYMENT.tr() +
          ' ' +
          transportationBaseModel.paymentValue.toString();
    }
    //WAIT_TAKE_OFF
    else if (transportationBaseModel.tripStatus ==
        TripStatusConstants.waitForTakeOff) {
      return AppStrings.tripStatusWAITTAKEOFF.tr() +
          DateHelper.formatDateTime(
            dateTime: DateTime.tryParse(
              transportationBaseModel.date ??
                  transportationBaseModel.creationDate!,
            ),
          );
    }
    //TAKE_OFF
    else if (transportationBaseModel.tripStatus ==
        TripStatusConstants.takeOff) {
      return AppStrings.tripStatusTAKEOFF.tr();
    }
    //EXECUTED
    else if (transportationBaseModel.tripStatus ==
        TripStatusConstants.executed) {
      return AppStrings.tripStatusEXECUTED.tr() +
          DateHelper.formatDateTime(
            dateTime: DateTime.tryParse(
              transportationBaseModel.date ??
                  transportationBaseModel.creationDate!,
            ),
          );
    }
    //CANCELLED BY PASSENGER
    else if (transportationBaseModel.tripStatus ==
            TripStatusConstants.cancelled ||
        transportationBaseModel.tripStatus ==
            TripStatusConstants.cancelledByPassenger) {
      return AppStrings.tripCancelledByPassneger.tr();
    }
    //CANCELLED BY DRIVER
    else if (transportationBaseModel.tripStatus ==
        TripStatusConstants.cancelled) {
      return AppStrings.tripCancelledByDriver.tr();
    }
    //COMPLETED
    else if (transportationBaseModel.tripStatus ==
        TripStatusConstants.completed) {
      return AppStrings.tripStatusCOMLETED.tr();
    }
    return '';
  }

  static Color getTextColor(TransportationBaseModel transportationBaseModel) {
    if (transportationBaseModel.tripStatus == TripStatusConstants.cancelled) {
      return ColorManager.error;
    } else if (transportationBaseModel.tripStatus ==
        TripStatusConstants.completed) {
      return ColorManager.green;
    } else {
      return ColorManager.primary;
    }
  }

  static String getTripTitle(String tripType) {
    if (tripType == TripTypeConstants.furnitureType) {
      return AppStrings.request.tr() +
          ' ' +
          AppStrings.furnitureTransportation.tr();
    } else if (tripType == TripTypeConstants.goodsType) {
      return AppStrings.request.tr() +
          ' ' +
          AppStrings.goodsTransportation.tr();
    } else if (tripType == TripTypeConstants.carAidType) {
      return AppStrings.request.tr() +
          ' ' +
          AppStrings.carAidTransportation.tr();
    } else if (tripType == TripTypeConstants.frozenType) {
      return AppStrings.request.tr() +
          ' ' +
          AppStrings.freezerTransportation.tr();
    } else if (tripType == TripTypeConstants.drinkWaterType) {
      return AppStrings.requestWhite.tr() +
          ' ' +
          AppStrings.waterTankTransportation.tr();
    } else if (tripType == TripTypeConstants.otherTankType) {
      return AppStrings.request.tr() +
          ' ' +
          AppStrings.cisternsTransportation.tr();
    } else {
      return '';
    }
  }

  static String getIconName(String tripType) {
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
}
