import 'package:flutter/material.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/di.dart';

import '../models/water_model.dart';

class WaterTankViewModel {
  final AppPreferences appPreferences = instance();
  WaterModel waterModel = WaterModel();
  ValueNotifier<bool> firstScreenValid = ValueNotifier(false);

  start(WaterModel waterModel) {
    this.waterModel = waterModel;
  }

  validateFirstScreen() {
    firstScreenValid.value = waterModel.tankDetails != null;
  }
}
