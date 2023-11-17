import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/lookups/model/lookups_model.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/di.dart';

import '../models/goods_model.dart';

class GoodsViewModel {
  final AppPreferences appPreferences = instance();
  GoodsModel goodsModel = GoodsModel();
  ValueNotifier<bool> firstScreenValid = ValueNotifier(false);

  start(GoodsModel goodsModel) {
    this.goodsModel = goodsModel;
  }

  validateFirstScreen() {
    firstScreenValid.value = goodsModel.materialType != null &&
        goodsModel.packagingType != null &&
        goodsModel.payloadWeight != null &&
        goodsModel.payloadWeight! > 0;
  }
}
