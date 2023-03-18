import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/domain/model/goods-model.dart';
import 'package:taxi_for_you/presentation/other/common/custom_images_show.dart';
import 'package:taxi_for_you/utils/resources/strings_manager.dart';
import '../../common/custom_info_widgets.dart';
import '../../common/custom_payment_field_show.dart';
import '../../../google_maps/view/google_maps_widget.dart';
import '../../common/custom_private_notes_show.dart';

class GoodsResultsWidget extends StatelessWidget {
  final GoodsModel goodsModel;

  const GoodsResultsWidget({Key? key, required this.goodsModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (goodsModel.date != null)
          CustomInfoStringWidget(
              info: AppStrings.scheduleAppoinment.tr(), text: goodsModel.date!),
        if (goodsModel.sourceLocationString != null)
          CustomInfoStringWidget(
              info: AppStrings.sourcePoint.tr(),
              text: goodsModel.sourceLocationString!),
        if (goodsModel.destinationLocationString != null)
          CustomInfoStringWidget(
              info: AppStrings.destinationPoint.tr(),
              text: goodsModel.destinationLocationString!),
        // SizedBox(
        //     height: 200,
        //     child: GoogleMapsWidget(
        //       sourceLocation: goodsModel.sourceLocation,
        //       destinationLocation: goodsModel.destinationLocation,
        //     )),
        Column(
          children: [
            CustomInfoIntWidget(
                info: AppStrings.goodsWeight.tr(),
                text: goodsModel.goodsWeight),
            CustomInfoBooleanWidget(
                booleanValue: goodsModel.craneBool,
                info: AppStrings.crane.tr()),
            CustomInfoBooleanWidget(
                booleanValue: goodsModel.loadingBool,
                info: AppStrings.unloadAndLoad.tr()),
            CustomInfoBooleanWidget(
                booleanValue: goodsModel.wrappingBool,
                info: AppStrings.wrapping.tr()),
            CustomShowImagesWidget(images: goodsModel.images),
            CustomPrivateNotesShow(notes: goodsModel.notes),
            CustomPaymentFieldShow(paymentValue: goodsModel.paymentValue)
          ],
        )
      ],
    );
  }
}
