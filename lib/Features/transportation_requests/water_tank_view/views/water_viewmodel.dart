import 'package:flutter/material.dart';

import '../models/water_model.dart';

class WaterTankViewModel {
  WaterModel waterModel = WaterModel();
  List<String> tankWeights = ["12000", "18000", "24000", "32000"];
  ValueNotifier<bool> firstScreenValid = ValueNotifier(false);

  start(WaterModel waterModel) {
    this.waterModel = waterModel;
  }

  validateFirstScreen() {
    firstScreenValid.value = waterModel.tankDetails != null;
  }
}
