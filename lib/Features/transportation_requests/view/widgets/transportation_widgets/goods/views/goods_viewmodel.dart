import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/lookups/model/lookups_model.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/di.dart';

import '../models/goods_model.dart';

class GoodsViewModel {
  final AppPreferences appPreferences = instance();
  GoodsModel goodsModel = GoodsModel();
  ValueNotifier<bool> firstScreenValid = ValueNotifier(false);
  List<LookupItem> materialTypes = [];
  List<LookupItem> packingTypes = [];

  start(GoodsModel goodsModel) {
    this.goodsModel = goodsModel;
    materialTypes = appPreferences.getLookupsInstance().materialTypes;
    packingTypes = appPreferences.getLookupsInstance().packingTypes;
  }

  validateFirstScreen() {
    firstScreenValid.value = goodsModel.materialType != null &&
        goodsModel.packingType != null &&
        goodsModel.payloadWeight != null &&
        goodsModel.payloadWeight! > 0;
  }
}
