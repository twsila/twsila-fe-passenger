import 'package:flutter/material.dart';
import 'package:taxi_for_you/domain/model/car-aid-model.dart';
import 'package:taxi_for_you/presentation/common/widgets/custom_payment_field.dart';
import 'package:taxi_for_you/presentation/common/widgets/custom_private_notes.dart';

class CarAidDataField extends StatelessWidget {
  final CarAidModel carAidModel;
  const CarAidDataField({Key? key, required this.carAidModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomPrivateNotes(
          onChanged: (text) {
            if (text != '' && text != null) {
              carAidModel.notes = text;
            } else {
              carAidModel.notes = null;
            }
          },
        ),
        CustomPaymentField(onChanged: (value) {
          if (value == '' && value != null) {
            carAidModel.paymentValue = null;
            return;
          }
          carAidModel.paymentValue = int.parse(value!);
        })
      ],
    );
  }
}
