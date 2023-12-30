import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/lookups/model/lookups_model.dart';

import '../../../../../../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../../../common/widgets/custom_dropdown.dart';
import '../water_viewmodel.dart';

class WaterDropdownView extends StatefulWidget {
  final WaterTankViewModel waterTankViewModel;
  const WaterDropdownView({
    Key? key,
    required this.waterTankViewModel,
  }) : super(key: key);

  @override
  State<WaterDropdownView> createState() => _WaterDropdownViewState();
}

class _WaterDropdownViewState extends State<WaterDropdownView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomDropDown(
          items: widget.waterTankViewModel.tankTypes,
          intialValue: widget.waterTankViewModel.waterModel.tankType,
          title: AppStrings.waterTankSize.tr(),
          errorMessage: AppStrings.dropdownError.tr(),
          onChanged: (value) {
            setState(() {
              if (value == null) return;
              widget.waterTankViewModel.waterModel.tankType = value;
              widget.waterTankViewModel.validateFirstScreen();
            });
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
