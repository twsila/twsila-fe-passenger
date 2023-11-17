import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/lookups/model/models/vehicle_type.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/persons/model/persons_model.dart';
import 'package:taxi_for_you/data/model/user-model.dart';

import '../../../../../../../app/app_prefs.dart';
import '../../../../../../../app/di.dart';

class PersonsViewModel {
  PersonsModel personsModel = PersonsModel();
  final AppPreferences appPreferences = instance();
  late List<VehicleType> vehicleTypes;
  String gender = "M";
  VehicleType? selectedVehicleType;
  ValueNotifier<bool> firstScreenValid = ValueNotifier(false);

  start(PersonsModel personsModel) {
    this.personsModel = personsModel;
    setModels();
  }

  setModels() {
    vehicleTypes = appPreferences.getVehicleInstance().vehicleType;
    UserModel userModel = appPreferences.getUserData()!;
    gender = userModel.gender ?? "M";
  }

  validateFirstScreen() {
    if (personsModel.vehicleType != null &&
        personsModel.numberOfPassengers != null) {
      firstScreenValid.value = true;
    } else {
      firstScreenValid.value = false;
    }
  }
}
