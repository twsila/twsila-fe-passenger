import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/lookups/model/lookups_model.dart';

import '../../../../../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../../../common/widgets/custom_dropdown.dart';
import '../freezers_viewmodel.dart';

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
        CustomDropDown(
          lookupKey: LookupConstants.shippingType,
          intialValue: null,
          title: AppStrings.shippedTypes.tr(),
          errorMessage: AppStrings.dropdownError.tr(),
          onChanged: (value) {
            setState(() {
              widget.freezersViewModel.freezersModel.shippedType = value;
              widget.freezersViewModel.validateFirstScreen();
            });
          },
        ),
        const SizedBox(height: 16),
        CustomDropDown(
          lookupKey: LookupConstants.materialType,
          intialValue: null,
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
