import '../../../../../model/transportation_base_model.dart';

class CarAidModel extends TransportationBaseModel {
  CarAidModel();

  CarAidModel.fromJson(Map<String, dynamic> json) {
    fromJSON(json);
  }

  Map<String, dynamic> toCarAidJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data = toJSON();
    return data;
  }
}
