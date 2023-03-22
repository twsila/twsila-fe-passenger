import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/domain/model/water-tank-model.dart';
import 'package:taxi_for_you/presentation/common/widgets/custom_payment_field.dart';
import 'package:taxi_for_you/presentation/common/widgets/custom_private_notes.dart';
import 'package:taxi_for_you/presentation/other/water_tank_view/water_viewmodel.dart';

import '../../../../utils/resources/strings_manager.dart';
import '../../../common/widgets/custom_dropdown.dart';

class WaterTankDataField extends StatefulWidget {
  final WaterTankViewModel waterTankViewModel;
  bool isValidWeight;
  WaterTankDataField({
    Key? key,
    required this.waterTankViewModel,
    required this.isValidWeight,
  }) : super(key: key);

  @override
  State<WaterTankDataField> createState() => _WaterTankDataFieldState();
}

class _WaterTankDataFieldState extends State<WaterTankDataField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomDropDown(
          stringsArr: widget.waterTankViewModel.tankWeights,
          intialValue: widget.waterTankViewModel.waterTankModel.tankWeight,
          title: AppStrings.tankWeight.tr(),
          isValid: widget.isValidWeight,
          errorMessage: AppStrings.dropdownError.tr(),
          onChanged: (value) {
            setState(() {
              widget.waterTankViewModel.waterTankModel.tankWeight = value;
            });
          },
        ),
        CustomPrivateNotes(
          onChanged: (text) {
            if (text != '' && text != null) {
              widget.waterTankViewModel.waterTankModel.notes = text;
            } else {
              widget.waterTankViewModel.waterTankModel.notes = null;
            }
          },
        ),
        CustomPaymentField(onChanged: (value) {
          if (value == '' && value != null) {
            widget.waterTankViewModel.waterTankModel.paymentValue = null;
            return;
          }
          widget.waterTankViewModel.waterTankModel.paymentValue =
              int.parse(value!);
        })
      ],
    );
  }
}
