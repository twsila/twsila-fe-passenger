import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/lookups/model/lookups_model.dart';

import '../../../../../../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../../../common/widgets/custom_dropdown.dart';
import '../cisterns_viewmodel.dart';

class CisternsDropdownsView extends StatefulWidget {
  final CisternsViewModel cisternsViewModel;
  const CisternsDropdownsView({
    Key? key,
    required this.cisternsViewModel,
  }) : super(key: key);

  @override
  State<CisternsDropdownsView> createState() => _CisternsDropdownsViewState();
}

class _CisternsDropdownsViewState extends State<CisternsDropdownsView> {
  @override
  void initState() {
    widget.cisternsViewModel.validateFirstScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomDropDown(
          lookupKey: LookupConstants.tankType,
          intialValue: widget.cisternsViewModel.cisternsModel.cisternsString,
          title: AppStrings.cisternsType.tr(),
          errorMessage: AppStrings.dropdownError.tr(),
          onChanged: (value) {
            setState(() {
              widget.cisternsViewModel.cisternsModel.cisternsType = value;
              widget.cisternsViewModel.validateFirstScreen();
            });
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
