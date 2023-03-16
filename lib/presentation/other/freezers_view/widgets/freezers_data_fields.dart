import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/presentation/common/widgets/custom_dropdown.dart';
import 'package:taxi_for_you/presentation/other/freezers_view/freezers_viewmodel.dart';

import '../../../../utils/resources/strings_manager.dart';
import '../../../common/widgets/custom_checkbox.dart';
import '../../../common/widgets/custom_number_field.dart';
import '../../../common/widgets/custom_payment_field.dart';
import '../../../common/widgets/custom_private_notes.dart';

class FreezersDataFields extends StatefulWidget {
  FreezersViewModel freezersViewModel;
  bool isValidType;
  bool isValidMaterial;
  FreezersDataFields({
    Key? key,
    required this.freezersViewModel,
    required this.isValidType,
    required this.isValidMaterial,
  }) : super(key: key);

  @override
  State<FreezersDataFields> createState() => _FreezersDataFieldsState();
}

class _FreezersDataFieldsState extends State<FreezersDataFields> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        CustomDropDown(
          stringsArr: widget.freezersViewModel.shippingTypes,
          title: AppStrings.shippedTypes.tr(),
          isValid: widget.isValidType,
          errorMessage: AppStrings.dropdownError.tr(),
          onChanged: (value) {
            widget.freezersViewModel.freezersModel.shippedType = value;
          },
        ),
        CustomDropDown(
          stringsArr: widget.freezersViewModel.materialsTobeShipped,
          title: AppStrings.materialsTobeShipped.tr(),
          isValid: widget.isValidMaterial,
          errorMessage: AppStrings.dropdownError.tr(),
          onChanged: (value) {
            widget.freezersViewModel.freezersModel.shippedMaterial = value;
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomCheckBox(
                      checked:
                          widget.freezersViewModel.freezersModel.loadingBool,
                      fieldName: AppStrings.unloadAndLoad.tr(),
                      onChange: (checked) {
                        widget.freezersViewModel.freezersModel.loadingBool =
                            checked;
                      }),
                  CustomCheckBox(
                      checked:
                          widget.freezersViewModel.freezersModel.cartonsBool,
                      fieldName: AppStrings.cartons.tr(),
                      onChange: (checked) {
                        widget.freezersViewModel.freezersModel.cartonsBool =
                            checked;
                      }),
                ],
              ),
            ),
            Flexible(
              child: CustomNumberField(
                  onChanged: (value) {
                    if (value == '' && value != null) {
                      widget.freezersViewModel.freezersModel.goodsWeight = null;
                      return;
                    }
                    widget.freezersViewModel.freezersModel.goodsWeight =
                        int.parse(value!);
                  },
                  text: AppStrings.goodsWeight.tr()),
            )
          ],
        ),
        CustomPrivateNotes(notes: widget.freezersViewModel.freezersModel.notes),
        CustomPaymentField(
          onChanged: (value) {
            if (value == '' && value != null) {
              widget.freezersViewModel.freezersModel.paymentValue = null;
              return;
            }
            widget.freezersViewModel.freezersModel.paymentValue =
                int.parse(value!);
          },
        )
      ],
    );
  }
}
