import 'package:flutter/material.dart';

import '../models/cisterns_model.dart';

class CisternsViewModel {
  CisternsModel cisternsModel = CisternsModel();
  List<String> cisternsTypes = ["نقل مياه غير صالحة للشرب", "شفط مياه صرف صحي"];
  ValueNotifier<bool> firstScreenValid = ValueNotifier(false);

  start(CisternsModel cisternsModel) {
    this.cisternsModel = cisternsModel;
  }

  validateFirstScreen() {
    firstScreenValid.value = cisternsModel.cisternsType != null;
  }
}
