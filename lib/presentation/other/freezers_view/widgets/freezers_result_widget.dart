import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/domain/model/freezers-model.dart';

import '../../../../app/app_prefs.dart';
import '../../../../app/di.dart';
import '../../../../utils/resources/strings_manager.dart';

class FreezersResultsWidget extends StatelessWidget {
  final FreezersModel freezersModel;
  final _appPrefs = instance<AppPreferences>();
  FreezersResultsWidget({Key? key, required this.freezersModel})
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
              textAlign: TextAlign.start,
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
          Text(
            info,
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(fontSize: 14),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            textAlign: TextAlign.start,
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
        children: [
          Text(
            info,
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(fontSize: 14),
          ),
          const SizedBox(width: 8),
          Text(
            booleanValue ? AppStrings.ok.tr() : AppStrings.no.tr(),
            textAlign: TextAlign.start,
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
        if (freezersModel.date != null)
          infoLargeWidget(
              context, AppStrings.scheduleAppoinment.tr(), freezersModel.date!),
        if (freezersModel.sourceLocationString != null)
          infoLargeWidget(context, AppStrings.sourcePoint.tr(),
              freezersModel.sourceLocationString!),
        if (freezersModel.destinationLocationString != null)
          infoLargeWidget(context, AppStrings.destinationPoint.tr(),
              freezersModel.destinationLocationString!),
        // SizedBox(
        //     height: 200,
        //     child: GoogleMapsWidget(
        //       sourceLocation: goodsModel.sourceLocation,
        //       destinationLocation: goodsModel.destinationLocation,
        //     )),
        Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      infoBooleanWidget(context, AppStrings.unloadAndLoad.tr(),
                          freezersModel.loadingBool),
                      infoBooleanWidget(context, AppStrings.cartons.tr(),
                          freezersModel.cartonsBool),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      infoWidget(
                          context,
                          AppStrings.goodsWeight.tr(),
                          freezersModel.goodsWeight != null
                              ? freezersModel.goodsWeight.toString()
                              : AppStrings.nothing.tr()),
                    ],
                  )
                ],
              ),
            ),
            infoWidget(
                context,
                AppStrings.shippedTypes.tr(),
                freezersModel.shippedType != null
                    ? freezersModel.shippedType.toString()
                    : AppStrings.nothing.tr()),
            infoWidget(
                context,
                AppStrings.materialsTobeShipped.tr(),
                freezersModel.shippedMaterial != null
                    ? freezersModel.shippedMaterial.toString()
                    : AppStrings.nothing.tr()),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  Text(
                    AppStrings.privateNotes.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontSize: 16),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      freezersModel.notes ?? AppStrings.nothing.tr(),
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
            freezersModel.paymentValue != null
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
                                freezersModel.paymentValue.toString(),
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
    ;
  }
}
