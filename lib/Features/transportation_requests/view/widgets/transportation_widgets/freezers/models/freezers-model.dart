import 'dart:convert';

import 'package:taxi_for_you/Features/lookups/model/lookups_model.dart';
import 'package:taxi_for_you/core/utils/helpers/double_prase.dart';

import '../../../../../model/transportation_base_model.dart';

class FreezersModel extends TransportationBaseModel {
  LookupItem? shippedType;
  LookupItem? frozenMaterial;
  double? payloadWeight;
  bool containsLoading = false;
  bool containsPacking = false;
  bool containsLift = false;

  FreezersModel();

  FreezersModel.fromJson(Map<String, dynamic> json) {
    fromJSON(json);
    shippedType = json['shippingType'] != null
        ? LookupItem(
            id: -1,
            value: json['shippingType'],
          )
        : null;
    if (json['payloadWeight'] != null) {
      payloadWeight = dynamicToDouble(json['payloadWeight']);
    }
    frozenMaterial = json['frozenMaterial'] != null
        ? LookupItem(
            id: json['frozenMaterial']['id'],
            value: json['frozenMaterial']['frozenType'],
          )
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
    if (shippedType != null) {
      data['shippingType'] = shippedType!.id.toString();
    }
    if (frozenMaterial != null) {
      data['frozenMaterial'] = frozenMaterial!.id.toString();
    }
    if (payloadWeight != null) {
      data['payloadWeight'] = payloadWeight.toString();
    }
    data['containsLoading'] = containsLoading.toString();
    data['containsPacking'] = containsPacking.toString();
    data['containsLift'] = containsLift.toString();
    return data;
  }

  FreezersModel copyWith(FreezersModel freezersModel) {
    return FreezersModel.fromJson(freezersModel.toFreezersJson());
  }
}
