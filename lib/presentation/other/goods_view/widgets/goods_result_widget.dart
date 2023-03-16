import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/domain/model/goods-model.dart';
import 'package:taxi_for_you/utils/resources/strings_manager.dart';

import '../../../../app/app_prefs.dart';
import '../../../../app/di.dart';
import '../../../google_maps/view/google_maps_widget.dart';

class GoodsResultsWidget extends StatelessWidget {
  final GoodsModel goodsModel;
  final _appPrefs = instance<AppPreferences>();

  GoodsResultsWidget({Key? key, required this.goodsModel}) : super(key: key);

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
        if (goodsModel.date != null)
          infoLargeWidget(
              context, AppStrings.scheduleAppoinment.tr(), goodsModel.date!),
        if (goodsModel.sourceLocationString != null)
          infoLargeWidget(context, AppStrings.sourcePoint.tr(),
              goodsModel.sourceLocationString!),
        if (goodsModel.destinationLocationString != null)
          infoLargeWidget(context, AppStrings.destinationPoint.tr(),
              goodsModel.destinationLocationString!),
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
                      infoBooleanWidget(
                          context, AppStrings.crane.tr(), goodsModel.craneBool),
                      infoWidget(
                          context,
                          AppStrings.goodsWeight.tr(),
                          goodsModel.goodsWeight != null
                              ? goodsModel.goodsWeight.toString()
                              : AppStrings.nothing.tr()),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      infoBooleanWidget(context, AppStrings.unloadAndLoad.tr(),
                          goodsModel.loadingBool),
                      infoBooleanWidget(context, AppStrings.wrapping.tr(),
                          goodsModel.wrappingBool),
                    ],
                  )
                ],
              ),
            ),
            goodsModel.images != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.pickedImages.tr(),
                        textAlign: TextAlign.start,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(fontSize: 18),
                      ),
                      Wrap(
                        children: goodsModel.images!.map((imageone) {
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
                      goodsModel.notes ?? AppStrings.nothing.tr(),
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
            goodsModel.paymentValue != null
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
                                goodsModel.paymentValue.toString(),
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
