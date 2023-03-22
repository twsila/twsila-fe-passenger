import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/domain/model/water-tank-model.dart';
import 'package:taxi_for_you/presentation/other/common/custom_info_widgets.dart';
import 'package:taxi_for_you/presentation/other/common/custom_private_notes_show.dart';

import '../../../../utils/resources/strings_manager.dart';
import '../../common/custom_payment_field_show.dart';

class WaterTankResultWidget extends StatelessWidget {
  final WaterTankModel waterTankModel;
  const WaterTankResultWidget({Key? key, required this.waterTankModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (waterTankModel.date != null)
          CustomInfoStringWidget(
            info: AppStrings.scheduleAppoinment.tr(),
            text: waterTankModel.date,
          ),
        if (waterTankModel.sourceLocationString != null)
          CustomInfoStringWidget(
            info: AppStrings.sourcePoint.tr(),
            text: waterTankModel.sourceLocationString,
          ),
        if (waterTankModel.destinationLocationString != null)
          CustomInfoStringWidget(
            info: AppStrings.destinationPoint.tr(),
            text: waterTankModel.destinationLocationString,
          ),
        CustomInfoStringWidget(
          info: AppStrings.tankWeight.tr(),
          text: waterTankModel.tankWeight,
        ),
        CustomPrivateNotesShow(notes: waterTankModel.notes),
        CustomPaymentFieldShow(paymentValue: waterTankModel.paymentValue)
      ],
    );
  }
}
