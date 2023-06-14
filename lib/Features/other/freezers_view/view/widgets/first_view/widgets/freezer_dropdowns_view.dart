import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/other/freezers_view/view/freezers_viewmodel.dart';

import '../../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../../../core/utils/resources/styles_manager.dart';
import '../../../../../../common/widgets/custom_dropdown.dart';

class FreezerDropdownsView extends StatefulWidget {
  final FreezersViewModel freezersViewModel;
  const FreezerDropdownsView({
    Key? key,
    required this.freezersViewModel,
  }) : super(key: key);

  @override
  State<FreezerDropdownsView> createState() => _FreezerDropdownsViewState();
}

class _FreezerDropdownsViewState extends State<FreezerDropdownsView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.transporationItems.tr(),
          textAlign: TextAlign.start,
          style:
              getMediumStyle(color: ColorManager.titlesTextColor, fontSize: 16),
        ),
        const SizedBox(height: 16),
        CustomDropDown(
          stringsArr: widget.freezersViewModel.shippingTypes,
          intialValue: widget.freezersViewModel.freezersModel.shippedType,
          title: AppStrings.shippedTypes.tr(),
          errorMessage: AppStrings.dropdownError.tr(),
          onChanged: (value) {
            setState(() {
              widget.freezersViewModel.freezersModel.shippedType = value;
              widget.freezersViewModel.validateFirstScreen();
            });
          },
        ),
        CustomDropDown(
          stringsArr: widget.freezersViewModel.materialsTobeShipped,
          intialValue: widget.freezersViewModel.freezersModel.frozenMaterial,
          title: AppStrings.materialsTobeShipped.tr(),
          errorMessage: AppStrings.dropdownError.tr(),
          onChanged: (value) {
            setState(() {
              widget.freezersViewModel.freezersModel.frozenMaterial = value;
              widget.freezersViewModel.validateFirstScreen();
            });
          },
        ),
      ],
    );
  }
}
