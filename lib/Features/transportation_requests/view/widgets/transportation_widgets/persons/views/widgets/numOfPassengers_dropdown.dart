import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/lookups/model/models/vehicle_type.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/persons/views/persons_viewmodel.dart';

import '../../../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../../../../core/utils/resources/styles_manager.dart';

class PersonsNumberOfPassengersDropdown extends StatefulWidget {
  final PersonsViewModel personsViewModel;
  final VehicleType vehicleType;
  const PersonsNumberOfPassengersDropdown({
    Key? key,
    required this.personsViewModel,
    required this.vehicleType,
  }) : super(key: key);

  @override
  State<PersonsNumberOfPassengersDropdown> createState() =>
      _PersonsNumberOfPassengersDropdownState();
}

class _PersonsNumberOfPassengersDropdownState
    extends State<PersonsNumberOfPassengersDropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.selectNumOfPassengers.tr(),
            style: getMediumStyle(
                color: ColorManager.titlesTextColor, fontSize: 14)),
        const SizedBox(height: 12),
        Wrap(
          runSpacing: 8,
          children: List.generate(
            widget.vehicleType.noOfPassengers.length,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  widget.personsViewModel.personsModel.numberOfPassengers =
                      widget.vehicleType.noOfPassengers[index];
                  widget.personsViewModel.validateFirstScreen();
                });
              },
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: widget.vehicleType.noOfPassengers[index] ==
                          widget
                              .personsViewModel.personsModel.numberOfPassengers
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
                    widget.vehicleType.noOfPassengers[index].toString(),
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
