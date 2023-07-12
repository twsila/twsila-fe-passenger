import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/common/state_renderer/dialogs.dart';
import 'package:taxi_for_you/Features/transportation_requests/model/transportation_base_model.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/di.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';

import '../../../../app/constants.dart';
import '../../../../core/utils/resources/assets_manager.dart';
import '../../../../core/utils/resources/langauge_manager.dart';
import '../../../../core/utils/resources/strings_manager.dart';
import '../../../../core/utils/resources/styles_manager.dart';
import '../../../transportation_requests/view/transport_request_view.dart';

class OldTripWidget extends StatefulWidget {
  final List<TransportationBaseModel> tripsList;
  const OldTripWidget({Key? key, required this.tripsList}) : super(key: key);

  @override
  State<OldTripWidget> createState() => _OldTripWidgetState();
}

class _OldTripWidgetState extends State<OldTripWidget> {
  final AppPreferences appPreferences = instance<AppPreferences>();

  String getString(String tripType) {
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
                              builder: (context) => TransportRequestScreen(
                                transportationBaseModel:
                                    widget.tripsList[index],
                              ),
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
                          child: Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(ImageAssets.clock),
                                  const SizedBox(width: 4),
                                  Text(
                                    getString(
                                        widget.tripsList[index].tripType!),
                                    style: getBoldStyle(
                                        color: ColorManager.primaryTextColor,
                                        fontSize: 12),
                                  ),
                                  const SizedBox(width: 4),
                                  Icon(
                                    appPreferences.getAppLanguage() ==
                                            LanguageType.ENGLISH.getValue()
                                        ? Icons.arrow_back
                                        : Icons.arrow_forward,
                                    color: ColorManager.primary,
                                    size: 16,
                                  ),
                                ],
                              ),
                              // const SizedBox(height: 4),
                              // GestureDetector(
                              //   onTap: () {
                              //     ShowDialogHelper.showDialogPopupWithCancel(
                              //         AppStrings.confirmation.tr(),
                              //         AppStrings.cancelRequestConfirmation.tr(),
                              //         context,
                              //         () => Navigator.pop(context), () {
                              //       appPreferences.removeTripByType(
                              //           widget.tripsList[index].tripType!);
                              //       Navigator.pop(context);
                              //     });
                              //   },
                              //   child: Text(
                              //     AppStrings.cancelRequest.tr(),
                              //     style: TextStyle(
                              //         color: ColorManager.primaryTextColor,
                              //         decoration: TextDecoration.underline),
                              //   ),
                              // )
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
