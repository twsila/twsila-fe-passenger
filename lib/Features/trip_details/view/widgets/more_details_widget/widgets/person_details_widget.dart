import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/lookups/model/vehicle_type.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/persons/model/persons_model.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/di.dart';

import '../../../../../../core/utils/resources/strings_manager.dart';
import '../item_widget.dart';

class PersonDetailsWidget extends StatefulWidget {
  final PersonsModel personsModel;

  const PersonDetailsWidget({Key? key, required this.personsModel})
      : super(key: key);

  @override
  State<PersonDetailsWidget> createState() => _PersonDetailsWidgetState();
}

class _PersonDetailsWidgetState extends State<PersonDetailsWidget> {
  final appPreferences = instance<AppPreferences>();
  VehicleType? vehicleType;
  int? numberOfPassengers;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _asyncMethod();
    });

    super.initState();
  }

  _asyncMethod() async {
    vehicleType = widget.personsModel.vehicleType != null
        ? appPreferences.getLookupsInstance().vehicleTypes.singleWhere(
            (element) => element.id == widget.personsModel.vehicleType!.id)
        : null;
    if (vehicleType != null) {
      numberOfPassengers = vehicleType!.noOfPassengers
          .singleWhere((element) =>
              element.id == widget.personsModel.numberOfPassengersId)
          .noOfPassengers;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ItemWidget(
                title: AppStrings.vehicleType.tr(),
                text: widget.personsModel.vehicleType!.vehicleType,
              ),
            ),
            Expanded(
              child: ItemWidget(
                title: AppStrings.numOfPassengers.tr(),
                text: numberOfPassengers != null
                    ? numberOfPassengers.toString()
                    : AppStrings.unknown.tr(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
