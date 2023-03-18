import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/domain/model/freezers-model.dart';
import 'package:taxi_for_you/presentation/other/common/custom_info_widgets.dart';
import 'package:taxi_for_you/presentation/other/common/custom_payment_field_show.dart';
import '../../../../utils/resources/strings_manager.dart';
import '../../common/custom_private_notes_show.dart';

class FreezersResultsWidget extends StatelessWidget {
  final FreezersModel freezersModel;
  const FreezersResultsWidget({Key? key, required this.freezersModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (freezersModel.date != null)
          CustomInfoStringWidget(
              info: AppStrings.scheduleAppoinment.tr(),
              text: freezersModel.date!),
        if (freezersModel.sourceLocationString != null)
          CustomInfoStringWidget(
              info: AppStrings.sourcePoint.tr(),
              text: freezersModel.sourceLocationString!),
        if (freezersModel.destinationLocationString != null)
          CustomInfoStringWidget(
              info: AppStrings.destinationPoint.tr(),
              text: freezersModel.destinationLocationString!),
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
              text: freezersModel.goodsWeight,
            ),
            CustomInfoBooleanWidget(
              booleanValue: freezersModel.loadingBool,
              info: AppStrings.unloadAndLoad.tr(),
            ),
            CustomInfoBooleanWidget(
              booleanValue: freezersModel.cartonsBool,
              info: AppStrings.cartons.tr(),
            ),
            CustomInfoStringWidget(
              info: AppStrings.shippedTypes.tr(),
              text: freezersModel.shippedType,
            ),
            CustomInfoStringWidget(
                info: AppStrings.materialsTobeShipped.tr(),
                text: freezersModel.shippedMaterial),
            CustomPrivateNotesShow(notes: freezersModel.notes),
            CustomPaymentFieldShow(paymentValue: freezersModel.paymentValue)
          ],
        )
      ],
    );
  }
}
