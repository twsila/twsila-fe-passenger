import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/domain/model/car-aid-model.dart';
import 'package:taxi_for_you/presentation/other/common/custom_private_notes_show.dart';

import '../../../../utils/resources/strings_manager.dart';
import '../../common/custom_info_widgets.dart';
import '../../common/custom_payment_field_show.dart';

class CarAidResultWidget extends StatelessWidget {
  final CarAidModel carAidModel;
  const CarAidResultWidget({Key? key, required this.carAidModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (carAidModel.date != null)
          CustomInfoStringWidget(
            info: AppStrings.scheduleAppoinment.tr(),
            text: carAidModel.date,
          ),
        if (carAidModel.sourceLocationString != null)
          CustomInfoStringWidget(
            info: AppStrings.sourcePoint.tr(),
            text: carAidModel.sourceLocationString,
          ),
        if (carAidModel.destinationLocationString != null)
          CustomInfoStringWidget(
            info: AppStrings.destinationPoint.tr(),
            text: carAidModel.destinationLocationString,
          ),
        CustomPrivateNotesShow(notes: carAidModel.notes),
        CustomPaymentFieldShow(paymentValue: carAidModel.paymentValue)
      ],
    );
  }
}
