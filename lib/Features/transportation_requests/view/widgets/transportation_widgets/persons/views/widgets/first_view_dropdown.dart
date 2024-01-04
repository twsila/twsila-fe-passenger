import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/persons/views/persons_viewmodel.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/persons/views/widgets/numOfPassengers_dropdown.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/persons/views/widgets/vehicle_type_dropdown.dart';

import '../../../../../../../../core/utils/resources/color_manager.dart';

class PersonDropdownView extends StatefulWidget {
  final PersonsViewModel personsViewModel;
  const PersonDropdownView({
    Key? key,
    required this.personsViewModel,
  }) : super(key: key);

  @override
  State<PersonDropdownView> createState() => _PersonDropdownViewState();
}

class _PersonDropdownViewState extends State<PersonDropdownView> {
  @override
  void initState() {
    if (widget.personsViewModel.personsModel.vehicleType != null) {
      widget.personsViewModel.selectedVehicleType =
          widget.personsViewModel.vehicleTypes.singleWhere((element) =>
              element == widget.personsViewModel.personsModel.vehicleType);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PersonsVehicleTypeDropdown(
          personsViewModel: widget.personsViewModel,
          setVehicleType: (vehicleType) {
            setState(() {
              widget.personsViewModel.selectedVehicleType = vehicleType;
              widget.personsViewModel.personsModel.vehicleType = vehicleType;
            });
          },
        ),
        if (widget.personsViewModel.selectedVehicleType != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Divider(color: ColorManager.darkGrey),
              PersonsNumberOfPassengersDropdown(
                personsViewModel: widget.personsViewModel,
                vehicleType: widget.personsViewModel.selectedVehicleType!,
              )
            ],
          ),
      ],
    );
  }
}
