import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../../../core/utils/resources/styles_manager.dart';
import '../../../../common/widgets/custom_checkbox.dart';
import '../../models/furniture_model.dart';

class FurnitureFirstViewBooleans extends StatefulWidget {
  final FurnitureModel furnitureModel;

  const FurnitureFirstViewBooleans({Key? key, required this.furnitureModel})
      : super(key: key);
  @override
  _FurnitureFirstViewBooleansState createState() =>
      _FurnitureFirstViewBooleansState();
}

class _FurnitureFirstViewBooleansState
    extends State<FurnitureFirstViewBooleans> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.extraServices.tr(),
          textAlign: TextAlign.start,
          style: getMediumStyle(
            color: ColorManager.titlesTextColor,
            fontSize: 16,
          ),
        ),
        CustomCheckBox(
          checked: widget.furnitureModel.containsAssemble,
          fieldName: AppStrings.assemble.tr(),
          onChange: (checked) {
            widget.furnitureModel.containsAssemble = checked;
          },
        ),
        CustomCheckBox(
            checked: widget.furnitureModel.containsLift,
            fieldName: AppStrings.crane.tr(),
            onChange: (checked) {
              widget.furnitureModel.containsLift = checked;
            }),
        CustomCheckBox(
            checked: widget.furnitureModel.containsLoading,
            fieldName: AppStrings.unloadAndLoad.tr(),
            onChange: (checked) {
              widget.furnitureModel.containsLoading = checked;
            }),
        CustomCheckBox(
            checked: widget.furnitureModel.containsPacking,
            fieldName: AppStrings.wrapping.tr(),
            onChange: (checked) {
              widget.furnitureModel.containsPacking = checked;
            }),
      ],
    );
  }
}
