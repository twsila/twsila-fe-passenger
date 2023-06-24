import 'package:taxi_for_you/Features/transportation_requests/common/common_repo/transportation_base_model.dart';

class CisternsModel extends TransportationBaseModel {
  String? cisternsType;

  CisternsModel();

  CisternsModel.fromJson(Map<String, dynamic> json) {
    fromJSON(json);
    cisternsType = json['cisternsType'];
  }

  Map<String, dynamic> toCisternsJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data = toJSON();
    if (cisternsType != null) data['tankType'] = 'SEWER'; //TODO: TO BE FIXED
    return data;
  }
}
