import 'package:taxi_for_you/Features/transportation_requests/common/common_repo/transportation_base_model.dart';

class FreezersModel extends TransportationBaseModel {
  String? shippedType;
  String? frozenMaterial;
  int? goodsWeight;
  bool containsLoading = false;
  bool containsPacking = false;
  bool containsLift = false;

  FreezersModel();

  FreezersModel.fromJson(Map<String, dynamic> json) {
    fromJSON(json);
    shippedType = json['shippingType'];
    frozenMaterial = json['frozenMaterial'];
    containsLoading = json['containsLoading'];
    containsPacking = json['containsPacking'];
    containsPacking = json['containsLift'];
  }

  Map<String, dynamic> toFreezersJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data = toJSON();
    if (shippedType != null) data['shippingType'] = 'DRY'; //TODO: TO BE FIXED
    if (frozenMaterial != null) data['frozenMaterial'] = frozenMaterial;
    data['containsLoading'] = containsLoading.toString();
    data['containsPacking'] = containsPacking.toString();
    data['containsLift'] = containsLift.toString();
    return data;
  }
}
