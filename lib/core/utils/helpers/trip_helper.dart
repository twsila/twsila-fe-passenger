import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:taxi_for_you/Features/transportation_requests/model/transportation_base_model.dart';
import 'package:taxi_for_you/core/utils/ext/date_ext.dart';

import '../../../app/constants.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/strings_manager.dart';

class TripHelper {
  static String getTripText(TransportationBaseModel transportationBaseModel) {
    //SUBMITTED
    if (transportationBaseModel.tripStatus == TripStatusConstants.submitted) {
      return AppStrings.tripStatusSUBMITTED.tr();
    }
    //EVALUATED
    if (transportationBaseModel.tripStatus == TripStatusConstants.evaluation) {
      return AppStrings.tripStatusEVALUATED.tr();
    }
    //PAYMENT
    else if (transportationBaseModel.tripStatus ==
        TripStatusConstants.payment) {
      return AppStrings.tripStatusPAYMENT.tr() +
          ' ' +
          (transportationBaseModel.acceptedOffer != null
              ? transportationBaseModel.acceptedOffer!.offer.driverOffer != 0.0
                  ? transportationBaseModel.acceptedOffer!.offer.driverOffer
                      .toString()
                  : transportationBaseModel.paymentValue.toString()
              : transportationBaseModel.paymentValue.toString());
    }
    //readyForTakeoff
    else if (transportationBaseModel.tripStatus ==
        TripStatusConstants.readyForTakeoff) {
      return AppStrings.tripStatusWAITTAKEOFF.tr() +
          (transportationBaseModel.launchDate != null
              ? transportationBaseModel.launchDate!.getTimeStampFromDate()
              : AppStrings.fastTime.tr());
    }
    //headingToPickupPoint
    else if (transportationBaseModel.tripStatus ==
        TripStatusConstants.headingToPickupPoint) {
      return AppStrings.tripStatusTAKEOFF.tr();
    }
    //arrivedToPickupPoint
    else if (transportationBaseModel.tripStatus ==
        TripStatusConstants.arrivedToPickupPoint) {
      return AppStrings.tripStatusEXECUTED.tr() +
          (transportationBaseModel.launchDate != null
              ? transportationBaseModel.launchDate!.getTimeStampFromDate()
              : AppStrings.fastTime.tr());
    }//arrivedToPickupPoint
    else if (transportationBaseModel.tripStatus ==
        TripStatusConstants.headingToDestination) {
      return AppStrings.headingToDestination.tr() +
          (transportationBaseModel.launchDate != null
              ? transportationBaseModel.launchDate!.getTimeStampFromDate()
              : AppStrings.fastTime.tr());
    }
    //CANCELLED BY PASSENGER
    else if (transportationBaseModel.tripStatus ==
        TripStatusConstants.cancelled) {
      if (transportationBaseModel.cancelledBy != null &&
          transportationBaseModel.cancelledBy ==
              TripStatusConstants.cancelledByDriver) {
        return AppStrings.tripCancelledByDriver.tr();
      }
      return AppStrings.tripCancelledByPassenger.tr();
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
    if (tripType == TripTypeConstants.personType) {
      return AppStrings.request.tr() +
          ' ' +
          AppStrings.personsTransportation.tr();
    } else if (tripType == TripTypeConstants.furnitureType) {
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
      case TripTypeConstants.personType:
        return ImageAssets.carPersons;
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
