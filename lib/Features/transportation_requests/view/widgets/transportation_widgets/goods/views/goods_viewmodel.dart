import 'package:flutter/material.dart';

import '../models/goods_model.dart';

class GoodsViewModel {
  GoodsModel goodsModel = GoodsModel();
  List<String> materialTypes = ["كراتين", "أكياس", "جوالين", "براميل", "بدون"];
  List<String> packagingTypes = [
    "محاصيل زراعية",
    "مواد بناء",
    "سوائل",
    "الات دقيقه",
    "حبوب"
  ];
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
