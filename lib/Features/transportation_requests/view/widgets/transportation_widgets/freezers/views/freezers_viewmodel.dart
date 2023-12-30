import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/lookups/model/lookups_model.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/di.dart';
import '../models/freezers-model.dart';

class FreezersViewModel {
  final AppPreferences appPreferences = instance();
  FreezersModel freezersModel = FreezersModel();
  ValueNotifier<bool> firstScreenValid = ValueNotifier(false);
  List<LookupItem> shippingTypes = [];
  List<LookupItem> frozenTypes = [];

  start(FreezersModel freezersModel) {
    this.freezersModel = freezersModel;
    shippingTypes = appPreferences.getLookupsInstance().shippingTypes;
    frozenTypes = appPreferences.getLookupsInstance().frozenTypes;
  }

  validateFirstScreen() {
    firstScreenValid.value = freezersModel.frozenType != null &&
        freezersModel.shippedType != null &&
        freezersModel.payloadWeight != null;
  }
}
