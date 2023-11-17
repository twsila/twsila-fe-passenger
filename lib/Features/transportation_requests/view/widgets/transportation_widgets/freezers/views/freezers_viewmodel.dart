import 'package:flutter/material.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/di.dart';
import '../models/freezers-model.dart';

class FreezersViewModel {
  final AppPreferences appPreferences = instance();
  FreezersModel freezersModel = FreezersModel();
  ValueNotifier<bool> firstScreenValid = ValueNotifier(false);

  start(FreezersModel freezersModel) {
    this.freezersModel = freezersModel;
  }

  validateFirstScreen() {
    firstScreenValid.value = freezersModel.frozenMaterial != null &&
        freezersModel.shippedType != null &&
        freezersModel.payloadWeight != null;
  }
}
