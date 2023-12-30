import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/lookups/model/lookups_model.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/di.dart';

import '../models/water_model.dart';

class WaterTankViewModel {
  final AppPreferences appPreferences = instance();
  WaterModel waterModel = WaterModel();
  ValueNotifier<bool> firstScreenValid = ValueNotifier(false);
  List<LookupItem> tankTypes = [];

  start(WaterModel waterModel) {
    this.waterModel = waterModel;
    tankTypes = appPreferences.getLookupsInstance().tankSizes;
  }

  validateFirstScreen() {
    firstScreenValid.value = waterModel.tankType != null;
  }
}
