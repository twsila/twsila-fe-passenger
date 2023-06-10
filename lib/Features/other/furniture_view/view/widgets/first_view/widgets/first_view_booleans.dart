import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/other/furniture_view/view/furniture_viewmodel.dart';

import '../../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../../../core/utils/resources/styles_manager.dart';
import '../../../../../../common/widgets/custom_checkbox.dart';

class FurnitureFirstViewBooleans extends StatefulWidget {
  final FurnitureViewModel furnitureViewModel;

  const FurnitureFirstViewBooleans({Key? key, required this.furnitureViewModel})
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
          checked: widget.furnitureViewModel.furnitureModel.containsAssemble,
          fieldName: AppStrings.assemble.tr(),
          onChange: (checked) {
            widget.furnitureViewModel.furnitureModel.containsAssemble = checked;
          },
        ),
        CustomCheckBox(
            checked: widget.furnitureViewModel.furnitureModel.containsLift,
            fieldName: AppStrings.crane.tr(),
            onChange: (checked) {
              widget.furnitureViewModel.furnitureModel.containsLift = checked;
            }),
        CustomCheckBox(
            checked: widget.furnitureViewModel.furnitureModel.containsLoading,
            fieldName: AppStrings.unloadAndLoad.tr(),
            onChange: (checked) {
              widget.furnitureViewModel.furnitureModel.containsLoading =
                  checked;
            }),
        CustomCheckBox(
            checked: widget.furnitureViewModel.furnitureModel.containsPacking,
            fieldName: AppStrings.wrapping.tr(),
            onChange: (checked) {
              widget.furnitureViewModel.furnitureModel.containsPacking =
                  checked;
            }),
      ],
    );
  }
}
