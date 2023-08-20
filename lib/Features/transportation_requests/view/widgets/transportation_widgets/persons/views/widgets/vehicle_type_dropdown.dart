import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/lookups/model/models/vehicle_type.dart';

import '../../../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../../../../core/utils/resources/styles_manager.dart';
import '../persons_viewmodel.dart';

class PersonsVehicleTypeDropdown extends StatefulWidget {
  final PersonsViewModel personsViewModel;
  final Function(VehicleType) setVehicleType;
  const PersonsVehicleTypeDropdown({
    Key? key,
    required this.personsViewModel,
    required this.setVehicleType,
  }) : super(key: key);

  @override
  State<PersonsVehicleTypeDropdown> createState() =>
      _PersonsVehicleTypeDropdownState();
}

class _PersonsVehicleTypeDropdownState
    extends State<PersonsVehicleTypeDropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.selectVehicleType.tr(),
            style: getMediumStyle(
                color: ColorManager.titlesTextColor, fontSize: 14)),
        const SizedBox(height: 12),
        Wrap(
          runSpacing: 8,
          children: List.generate(
            widget.personsViewModel.vehicleTypes.length,
            (index) => GestureDetector(
              onTap: () {
                widget.setVehicleType(
                    widget.personsViewModel.vehicleTypes[index]);

                widget.personsViewModel.validateFirstScreen();
              },
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: widget.personsViewModel.vehicleTypes[index].id ==
                          widget.personsViewModel.personsModel.vehicleType
                      ? ColorManager.secondaryLightColor
                      : Colors.transparent,
                  border: Border.all(
                    color: ColorManager.lightPrimary,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Text(
                    widget.personsViewModel.vehicleTypes[index].name,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: ColorManager.secondaryColor,
                          fontSize: 16,
                        ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
