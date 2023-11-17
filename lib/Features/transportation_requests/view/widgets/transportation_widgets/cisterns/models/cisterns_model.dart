import 'package:taxi_for_you/Features/lookups/model/lookups_model.dart';

import '../../../../../model/transportation_base_model.dart';

class CisternsModel extends TransportationBaseModel {
  LookupItem? cisternsType;
  String? cisternsString;

  CisternsModel();

  CisternsModel.fromJson(Map<String, dynamic> json) {
    fromJSON(json);
    cisternsString = json['tankType'];
  }

  Map<String, dynamic> toCisternsJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data = toJSON();
    if (cisternsType != null) {
      data['tankType'] = cisternsType!.id.toString();
    }
    return data;
  }

  CisternsModel copyWith(CisternsModel cisternsModel) {
    return CisternsModel.fromJson(cisternsModel.toCisternsJson());
  }
}
