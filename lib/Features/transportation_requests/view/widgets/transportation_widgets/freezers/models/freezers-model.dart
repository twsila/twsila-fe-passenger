import 'package:taxi_for_you/core/utils/helpers/double_prase.dart';

import '../../../../../model/transportation_base_model.dart';

class FreezersModel extends TransportationBaseModel {
  String? shippedType;
  String? frozenMaterial;
  bool containsLoading = false;
  bool containsPacking = false;
  bool containsLift = false;

  FreezersModel();

  FreezersModel.fromJson(Map<String, dynamic> json) {
    fromJSON(json);
    shippedType = json['shippingType'];
    frozenMaterial = json['frozenMaterial'] is String
        ? json['frozenMaterial']
        : json['frozenMaterial'] != null
            ? json['frozenMaterial']['description']
            : null;
    containsLoading = json['containsLoading'] is String
        ? json['containsLoading'] == "true"
        : json['containsLoading'];
    containsPacking = json['containsPacking'] is String
        ? json['containsPacking'] == "true"
        : json['containsPacking'];
    containsPacking = json['containsLift'] is String
        ? json['containsLift'] == "true"
        : json['containsLift'];
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

  FreezersModel copyWith(FreezersModel freezersModel) {
    return FreezersModel.fromJson(freezersModel.toFreezersJson());
  }
}
