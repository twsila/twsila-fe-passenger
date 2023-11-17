import 'dart:convert';

import 'package:taxi_for_you/Features/lookups/model/lookups_model.dart';

import '../../../../../model/transportation_base_model.dart';

class WaterModel extends TransportationBaseModel {
  LookupItem? tankDetails;

  WaterModel();

  WaterModel.fromJson(Map<String, dynamic> json) {
    fromJSON(json);
    tankDetails = json['tankDetails'] != null
        ? LookupItem(
            id: json['tankDetails']['id'],
            value: json['tankDetails']['totalSize'].toString(),
          )
        : null;
  }

  Map<String, dynamic> toWaterJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data = toJSON();
    if (tankDetails != null) {
      data['tankDetails'] = json.encode({
        "totalSize": tankDetails!.value.toString(),
        "height": 12.0,
        "length": 5.0,
        "width": 9.0
      });
    }
    return data;
  }

  WaterModel copyWith(WaterModel waterModel) {
    return WaterModel.fromJson(waterModel.toWaterJson());
  }
}
