import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/di.dart';
import 'package:taxi_for_you/utils/resources/strings_manager.dart';

import '../../../../domain/model/furniture-model.dart';
import '../../../google_maps/view/google_maps_widget.dart';

class FurnitureResultsWidget extends StatelessWidget {
  final _appPrefs = instance<AppPreferences>();
  final FurnitureModel furnitureModel;

  FurnitureResultsWidget({Key? key, required this.furnitureModel})
      : super(key: key);

  Widget infoLargeWidget(BuildContext context, String info, String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Text(
            info,
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(fontSize: 14),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.end,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget infoWidget(BuildContext context, String info, String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              info,
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(fontSize: 14),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            textAlign: TextAlign.end,
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget infoBooleanWidget(
      BuildContext context, String info, bool booleanValue) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              info,
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(fontSize: 14),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            booleanValue ? AppStrings.yes.tr() : AppStrings.no.tr(),
            textAlign: TextAlign.end,
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (furnitureModel.date != null)
          infoLargeWidget(context, AppStrings.scheduleAppoinment.tr(),
              furnitureModel.date!),
        if (furnitureModel.sourceLocationString != null)
          infoLargeWidget(context, AppStrings.sourcePoint.tr(),
              furnitureModel.sourceLocationString!),
        if (furnitureModel.destinationLocationString != null)
          infoLargeWidget(context, AppStrings.destinationPoint.tr(),
              furnitureModel.destinationLocationString!),
        // SizedBox(
        //     height: 200,
        //     child: GoogleMapsWidget(
        //       sourceLocation: furnitureModel.sourceLocation,
        //       destinationLocation: furnitureModel.destinationLocation,
        //     )),
        Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        infoBooleanWidget(context, AppStrings.assemble.tr(),
                            furnitureModel.assembleBool),
                        infoBooleanWidget(context, AppStrings.crane.tr(),
                            furnitureModel.craneBool),
                        infoWidget(
                            context,
                            AppStrings.fridgeNumber.tr(),
                            furnitureModel.fridgeNumber != null
                                ? furnitureModel.fridgeNumber.toString()
                                : AppStrings.nothing.tr()),
                        infoWidget(
                            context,
                            AppStrings.carpetsNumber.tr(),
                            furnitureModel.carpetsNumber != null
                                ? furnitureModel.carpetsNumber.toString()
                                : AppStrings.nothing.tr()),
                        infoWidget(
                            context,
                            AppStrings.kitchenNumber.tr(),
                            furnitureModel.kitchenNumber != null
                                ? furnitureModel.kitchenNumber.toString()
                                : AppStrings.nothing.tr()),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        infoBooleanWidget(
                            context,
                            AppStrings.unloadAndLoad.tr(),
                            furnitureModel.loadingBool),
                        infoBooleanWidget(context, AppStrings.wrapping.tr(),
                            furnitureModel.wrappingBool),
                        infoWidget(
                            context,
                            AppStrings.bedNumber.tr(),
                            furnitureModel.roomsNumber != null
                                ? furnitureModel.roomsNumber.toString()
                                : AppStrings.nothing.tr()),
                        infoWidget(
                            context,
                            AppStrings.sofaSet.tr(),
                            furnitureModel.chairsNumber != null
                                ? furnitureModel.chairsNumber.toString()
                                : AppStrings.nothing.tr()),
                        infoWidget(
                            context,
                            AppStrings.airconditionarNumber.tr(),
                            furnitureModel.airconditionerNumber != null
                                ? furnitureModel.airconditionerNumber.toString()
                                : AppStrings.nothing.tr()),
                        infoWidget(
                            context,
                            AppStrings.dinningRoomNumber.tr(),
                            furnitureModel.diningRoomNumber != null
                                ? furnitureModel.diningRoomNumber.toString()
                                : AppStrings.nothing.tr()),
                      ],
                    ),
                  )
                ],
              ),
            ),
            furnitureModel.images != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.pickedImages.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(fontSize: 18),
                      ),
                      Wrap(
                        children: furnitureModel.images!.map((imageone) {
                          return Card(
                            child: SizedBox(
                              height: 100,
                              width: 100,
                              child: Image.file(File(imageone.path)),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  )
                : Container(),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      AppStrings.privateNotes.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontSize: 16),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      furnitureModel.notes ?? AppStrings.nothing.tr(),
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            furnitureModel.paymentValue != null
                ? Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      children: [
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            AppStrings.paymentValue.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(fontSize: 16),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                furnitureModel.paymentValue.toString(),
                                textAlign: TextAlign.start,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontSize: 12),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                _appPrefs.getUserSelectedCountry() == "SA"
                                    ? AppStrings.saudiCurrency.tr()
                                    : AppStrings.egpCurrency.tr(),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox()
          ],
        )
      ],
    );
  }
}
