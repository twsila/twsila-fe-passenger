import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/transportation_requests/freezers_view/view/freezers_viewmodel.dart';

import '../../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../../../core/utils/resources/styles_manager.dart';
import '../../../../../../common/widgets/custom_checkbox.dart';

class FreezerBooleanView extends StatefulWidget {
  final FreezersViewModel freezersViewModel;
  const FreezerBooleanView({
    Key? key,
    required this.freezersViewModel,
  }) : super(key: key);

  @override
  State<FreezerBooleanView> createState() => _FreezerBooleanViewState();
}

class _FreezerBooleanViewState extends State<FreezerBooleanView> {
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
          checked: widget.freezersViewModel.freezersModel.containsLoading,
          fieldName: AppStrings.unloadAndLoad.tr(),
          onChange: (checked) {
            widget.freezersViewModel.freezersModel.containsLoading = checked;
          },
        ),
        CustomCheckBox(
            checked: widget.freezersViewModel.freezersModel.containsPacking,
            fieldName: AppStrings.cartons.tr(),
            onChange: (checked) {
              widget.freezersViewModel.freezersModel.containsPacking = checked;
            }),
        CustomCheckBox(
            checked: widget.freezersViewModel.freezersModel.containsLift,
            fieldName: AppStrings.crane.tr(),
            onChange: (checked) {
              widget.freezersViewModel.freezersModel.containsLift = checked;
            }),
      ],
    );
  }
}
