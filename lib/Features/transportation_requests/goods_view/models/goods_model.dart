import 'package:taxi_for_you/Features/transportation_requests/common/common_repo/transportation_base_model.dart';

class GoodsModel extends TransportationBaseModel {
  String? packagingType;
  String? materialType;
  int? payloadWeight;
  bool containsLoading = false;
  bool containsPacking = false;
  bool containsLift = false;

  GoodsModel();

  GoodsModel.fromJson(Map<String, dynamic> json) {
    fromJSON(json);
    payloadWeight = json['payloadWeight'];
    packagingType = json['packagingType'];
    materialType = json['materialType'];
    containsLoading = json['containsLoading'];
    containsPacking = json['containsPacking'];
    containsLift = json['containsLift'];
  }

  Map<String, dynamic> toGoodsJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data = toJSON();
    if (payloadWeight != null) {
      data['payloadWeight'] = payloadWeight.toString();
    }
    data['packagingType'] = packagingType.toString();
    data['materialType'] = materialType.toString();
    data['containsLoading'] = containsLoading.toString();
    data['containsPacking'] = containsPacking.toString();
    data['containsLift'] = containsLift.toString();
    return data;
  }
}
