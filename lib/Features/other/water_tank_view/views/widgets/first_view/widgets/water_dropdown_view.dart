import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/other/water_tank_view/views/water_viewmodel.dart';

import '../../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../../common/widgets/custom_dropdown.dart';

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
          stringsArr: widget.waterTankViewModel.tankWeights,
          intialValue: widget.waterTankViewModel.waterModel.tankDetails,
          title: AppStrings.waterTankSize.tr(),
          errorMessage: AppStrings.dropdownError.tr(),
          onChanged: (value) {
            setState(() {
              widget.waterTankViewModel.waterModel.tankDetails = value;
              widget.waterTankViewModel.validateFirstScreen();
            });
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
