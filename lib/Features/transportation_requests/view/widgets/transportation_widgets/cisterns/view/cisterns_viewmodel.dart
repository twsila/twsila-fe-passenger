import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/lookups/model/lookups_model.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/di.dart';

import '../models/cisterns_model.dart';

class CisternsViewModel {
  final AppPreferences appPreferences = instance();
  CisternsModel cisternsModel = CisternsModel();
  ValueNotifier<bool> firstScreenValid = ValueNotifier(false);
  List<LookupItem> tankTypes = [];

  start(CisternsModel cisternsModel) {
    this.cisternsModel = cisternsModel;
    tankTypes = appPreferences.getLookupsInstance().tankTypes;
  }

  validateFirstScreen() {
    firstScreenValid.value = cisternsModel.cisternsType != null;
  }
}
