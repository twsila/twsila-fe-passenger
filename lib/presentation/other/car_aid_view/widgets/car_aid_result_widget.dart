import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/domain/model/car-aid-model.dart';
import 'package:taxi_for_you/presentation/other/common/custom_private_notes_show.dart';

import '../../../../utils/resources/strings_manager.dart';
import '../../common/custom_payment_field_show.dart';

class CarAidResultWidget extends StatelessWidget {
  final CarAidModel carAidModel;
  const CarAidResultWidget({Key? key, required this.carAidModel})
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (carAidModel.date != null)
          infoLargeWidget(
              context, AppStrings.scheduleAppoinment.tr(), carAidModel.date!),
        if (carAidModel.sourceLocationString != null)
          infoLargeWidget(context, AppStrings.sourcePoint.tr(),
              carAidModel.sourceLocationString!),
        if (carAidModel.destinationLocationString != null)
          infoLargeWidget(context, AppStrings.destinationPoint.tr(),
              carAidModel.destinationLocationString!),
        CustomPrivateNotesShow(notes: carAidModel.notes),
        CustomPaymentFieldShow(paymentValue: carAidModel.paymentValue)
      ],
    );
  }
}
