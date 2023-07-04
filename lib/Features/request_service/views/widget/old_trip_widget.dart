import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/transportation_requests/model/transportation_base_model.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/constants.dart';
import 'package:taxi_for_you/app/di.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';

import '../../../../core/utils/resources/assets_manager.dart';
import '../../../../core/utils/resources/langauge_manager.dart';
import '../../../../core/utils/resources/strings_manager.dart';
import '../../../../core/utils/resources/styles_manager.dart';
import '../../../trip_details/view/trip_details_screen.dart';

class OldTripWidget extends StatefulWidget {
  final List<TransportationBaseModel> tripsList;
  const OldTripWidget({Key? key, required this.tripsList}) : super(key: key);

  @override
  State<OldTripWidget> createState() => _OldTripWidgetState();
}

class _OldTripWidgetState extends State<OldTripWidget> {
  final AppPreferences _appPrefs = instance<AppPreferences>();

  String getString(String endPoint) {
    if (endPoint == EndPointsConstants.sendFurnitureRequest) {
      return AppStrings.request.tr() +
          ' ' +
          AppStrings.furnitureTransportation.tr();
    } else if (endPoint == EndPointsConstants.sendGoodsRequest) {
      return AppStrings.request.tr() +
          ' ' +
          AppStrings.goodsTransportation.tr();
    } else if (endPoint == EndPointsConstants.sendCarAidRequest) {
      return AppStrings.request.tr() +
          ' ' +
          AppStrings.carAidTransportation.tr();
    } else if (endPoint == EndPointsConstants.sendFreezersRequest) {
      return AppStrings.request.tr() +
          ' ' +
          AppStrings.freezerTransportation.tr();
    } else if (endPoint == EndPointsConstants.sendWaterRequest) {
      return AppStrings.requestWhite.tr() +
          ' ' +
          AppStrings.waterTankTransportation.tr();
    } else if (endPoint == EndPointsConstants.sendCisternsRequest) {
      return AppStrings.request.tr() +
          ' ' +
          AppStrings.cisternsTransportation.tr();
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.continueRequest.tr(),
            textAlign: TextAlign.start,
            style: getBoldStyle(
                color: ColorManager.primaryTextColor, fontSize: 18),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.spaceBetween,
              runSpacing: 16,
              spacing: 16,
              children: List.generate(
                  widget.tripsList.length,
                  (index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TripDetailsScreen(
                                  tripId: widget.tripsList[index].tripId!),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            color: ColorManager.accentColor,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(ImageAssets.clock),
                              const SizedBox(width: 4),
                              Text(
                                getString(
                                    widget.tripsList[index].tripEndPoint!),
                                style: getBoldStyle(
                                    color: ColorManager.primaryTextColor,
                                    fontSize: 12),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                _appPrefs.getAppLanguage() ==
                                        LanguageType.ENGLISH.getValue()
                                    ? Icons.arrow_back
                                    : Icons.arrow_forward,
                                color: ColorManager.primary,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      )),
            ),
          ),
        ],
      ),
    );
  }
}
