import 'package:taxi_for_you/Features/transportation_requests/common/common_repo/transportation_base_model.dart';

class WaterModel extends TransportationBaseModel {
  String? tankDetails;

  WaterModel();

  WaterModel.fromJson(Map<String, dynamic> json) {
    fromJSON(json);
    tankDetails = json['tankDetails'];
  }

  Map<String, dynamic> toWaterJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data = toJSON();
    data['tankDetails'] = tankDetails.toString();
    return data;
  }
}
