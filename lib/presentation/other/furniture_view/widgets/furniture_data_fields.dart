import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/presentation/common/widgets/custom_number_field.dart';
import 'package:taxi_for_you/presentation/common/widgets/custom_private_notes.dart';
import 'package:taxi_for_you/utils/resources/strings_manager.dart';

import '../../../../domain/model/furniture-model.dart';
import '../../../common/widgets/custom_checkbox.dart';
import '../../../common/widgets/custom_payment_field.dart';
import '../../../common/widgets/custom_text_input_field.dart';
import '../../../common/widgets/multi_pick_image.dart';

class FurnitureDataFields extends StatefulWidget {
  final FurnitureModel furnitureModel;
  const FurnitureDataFields({Key? key, required this.furnitureModel})
      : super(key: key);

  @override
  State<FurnitureDataFields> createState() => _FurnitureDataFieldsState();
}

class _FurnitureDataFieldsState extends State<FurnitureDataFields> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomCheckBox(
                      checked: widget.furnitureModel.assembleBool,
                      fieldName: AppStrings.assemble.tr(),
                      onChange: (checked) {
                        widget.furnitureModel.assembleBool = checked;
                      }),
                  CustomCheckBox(
                      checked: widget.furnitureModel.craneBool,
                      fieldName: AppStrings.crane.tr(),
                      onChange: (checked) {
                        widget.furnitureModel.craneBool = checked;
                      }),
                  CustomNumberField(
                      onChanged: (value) {
                        if (value == '' && value != null) {
                          widget.furnitureModel.fridgeNumber = null;
                          return;
                        }
                        widget.furnitureModel.fridgeNumber = int.parse(value!);
                      },
                      text: AppStrings.fridgeNumber.tr()),
                  CustomNumberField(
                    onChanged: (value) {
                      if (value == '' && value != null) {
                        widget.furnitureModel.carpetsNumber = null;
                        return;
                      }
                      widget.furnitureModel.carpetsNumber = int.parse(value!);
                    },
                    text: AppStrings.carpetsNumber.tr(),
                  ),
                  CustomNumberField(
                      onChanged: (value) {
                        if (value == '' && value != null) {
                          widget.furnitureModel.kitchenNumber = null;
                          return;
                        }
                        widget.furnitureModel.kitchenNumber = int.parse(value!);
                      },
                      text: AppStrings.kitchenNumber.tr()),
                  const SizedBox(height: 70)
                ],
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomCheckBox(
                      checked: widget.furnitureModel.loadingBool,
                      fieldName: AppStrings.unloadAndLoad.tr(),
                      onChange: (checked) {
                        widget.furnitureModel.loadingBool = checked;
                      }),
                  CustomCheckBox(
                      checked: widget.furnitureModel.wrappingBool,
                      fieldName: AppStrings.wrapping.tr(),
                      onChange: (checked) {
                        widget.furnitureModel.wrappingBool = checked;
                      }),
                  CustomNumberField(
                    onChanged: (value) {
                      if (value == '' && value != null) {
                        widget.furnitureModel.roomsNumber = null;
                        return;
                      }
                      widget.furnitureModel.roomsNumber = int.parse(value!);
                    },
                    text: AppStrings.bedNumber.tr(),
                  ),
                  CustomNumberField(
                    onChanged: (value) {
                      if (value == '' && value != null) {
                        widget.furnitureModel.chairsNumber = null;
                        return;
                      }
                      widget.furnitureModel.chairsNumber = int.parse(value!);
                    },
                    text: AppStrings.sofaSet.tr(),
                  ),
                  CustomNumberField(
                      onChanged: (value) {
                        if (value == '' && value != null) {
                          widget.furnitureModel.roomsNumber = null;
                          return;
                        }
                        widget.furnitureModel.roomsNumber = int.parse(value!);
                      },
                      text: AppStrings.airconditionarNumber.tr()),
                  CustomNumberField(
                    onChanged: (value) {
                      if (value == '' && value != null) {
                        widget.furnitureModel.diningRoomNumber = null;
                        return;
                      }
                      widget.furnitureModel.diningRoomNumber =
                          int.parse(value!);
                    },
                    text: AppStrings.dinningRoomNumber.tr(),
                  ),
                ],
              ),
            )
          ],
        ),
        MutliPickImageWidget(
          onPickedImages: (images) => widget.furnitureModel.images = images,
        ),
        CustomPrivateNotes(
          onChanged: (text) {
            if (text != '' && text != null) {
              widget.furnitureModel.notes = text;
            } else {
              widget.furnitureModel.notes = null;
            }
          },
        ),
        CustomPaymentField(
          onChanged: (value) {
            if (value == '' && value != null) {
              widget.furnitureModel.paymentValue = null;
              return;
            }
            widget.furnitureModel.paymentValue = int.parse(value!);
          },
        )
      ],
    );
  }
}
