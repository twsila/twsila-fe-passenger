import 'package:taxi_for_you/core/utils/helpers/double_prase.dart';

import '../../../../../model/transportation_base_model.dart';

class GoodsModel extends TransportationBaseModel {
  String? packagingType;
  String? materialType;
  double? payloadWeight;
  bool containsLoading = false;
  bool containsPacking = false;
  bool containsLift = false;

  GoodsModel();

  GoodsModel.fromJson(Map<String, dynamic> json) {
    fromJSON(json);
    if (json['payloadWeight'] != null) {
      payloadWeight = dynamicToDouble(json['payloadWeight']);
    }
    if (json['packagingType'] != null) {
      packagingType = json['packagingType'];
    }
    if (json['materialType'] != null) {
      materialType = json['materialType'];
    }
    containsLoading = json['containsLoading'] is String
        ? json['containsLoading'] == "true"
        : json['containsLoading'];
    containsPacking = json['containsPacking'] is String
        ? json['containsPacking'] == "true"
        : json['containsPacking'];
    containsLift = json['containsLift'] is String
        ? json['containsLift'] == true
        : json['containsLift'];
  }

  Map<String, dynamic> toGoodsJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data = toJSON();
    if (payloadWeight != null) {
      data['payloadWeight'] = payloadWeight.toString();
    }
    if (packagingType != null) data['packagingType'] = packagingType.toString();
    if (materialType != null) data['materialType'] = materialType.toString();
    data['containsLoading'] = containsLoading.toString();
    data['containsPacking'] = containsPacking.toString();
    data['containsLift'] = containsLift.toString();
    return data;
  }

  GoodsModel copyWith(GoodsModel goodsModel) {
    return GoodsModel.fromJson(goodsModel.toGoodsJson());
  }
}
