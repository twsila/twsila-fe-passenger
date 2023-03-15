import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/utils/resources/strings_manager.dart';

import '../../../../domain/model/furniture-model.dart';
import '../../../common/widgets/custom_checkbox.dart';
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
  Widget numberField(String text, Widget widget) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 45,
          child: widget,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.displaySmall,
          ),
        )
      ],
    );
  }

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
                  numberField(
                      AppStrings.fridgeNumber.tr(),
                      CustomTextInputField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (value == '') {
                            widget.furnitureModel.fridgeNumber = null;
                            return;
                          }
                          widget.furnitureModel.fridgeNumber = int.parse(value);
                        },
                      )),
                  numberField(
                      AppStrings.carpetsNumber.tr(),
                      CustomTextInputField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (value == '') {
                            widget.furnitureModel.carpetsNumber = null;
                            return;
                          }
                          widget.furnitureModel.carpetsNumber =
                              int.parse(value);
                        },
                      )),
                  numberField(
                      AppStrings.kitchenNumber.tr(),
                      CustomTextInputField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (value == '') {
                            widget.furnitureModel.kitchenNumber = null;
                            return;
                          }
                          widget.furnitureModel.kitchenNumber =
                              int.parse(value);
                        },
                      )),
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
                  numberField(
                      AppStrings.bedNumber.tr(),
                      CustomTextInputField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (value == '') {
                            widget.furnitureModel.roomsNumber = null;
                            return;
                          }
                          widget.furnitureModel.roomsNumber = int.parse(value);
                        },
                      )),
                  numberField(
                      AppStrings.sofaSet.tr(),
                      CustomTextInputField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (value == '') {
                            widget.furnitureModel.chairsNumber = null;
                            return;
                          }
                          widget.furnitureModel.chairsNumber = int.parse(value);
                        },
                      )),
                  numberField(
                      AppStrings.airconditionarNumber.tr(),
                      CustomTextInputField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (value == '') {
                            widget.furnitureModel.airconditionerNumber = null;
                            return;
                          }
                          widget.furnitureModel.airconditionerNumber =
                              int.parse(value);
                        },
                      )),
                  numberField(
                      AppStrings.dinningRoomNumber.tr(),
                      CustomTextInputField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (value == '') {
                            widget.furnitureModel.diningRoomNumber = null;
                            return;
                          }
                          widget.furnitureModel.diningRoomNumber =
                              int.parse(value);
                        },
                      )),
                ],
              ),
            )
          ],
        ),
        MutliPickImageWidget(
          onPickedImages: (images) => widget.furnitureModel.images = images,
        ),
        Container(
          margin: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                child: CustomTextInputField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  padding: const EdgeInsets.all(8),
                  onChanged: (text) {
                    widget.furnitureModel.notes = text;
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
