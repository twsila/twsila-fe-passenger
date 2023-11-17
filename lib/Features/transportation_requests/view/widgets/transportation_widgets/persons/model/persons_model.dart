import '../../../../../model/transportation_base_model.dart';

class PersonsModel extends TransportationBaseModel {
  bool isWoman = false;
  String? vehicleType;
  int? vehicleId;
  int? numberOfPassengers;

  PersonsModel();

  PersonsModel.fromJson(Map<String, dynamic> json) {
    fromJSON(json);
    isWoman = json['isWoman'] == null
        ? false
        : json['isWoman'] is String
            ? json['isWoman'] == 'true'
            : json['isWoman'];
    vehicleType = json['vehicleType'];
    numberOfPassengers = json['numberOfPassengers'] is String
        ? int.parse(json['numberOfPassengers'])
        : json['numberOfPassengers'];
  }

  Map<String, dynamic> toPersonsJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data = toJSON();
    if (vehicleType != null) {
      data['vehicleType'] = vehicleId.toString();
    }
    if (numberOfPassengers != null) {
      data['numberOfPassengers'] = numberOfPassengers.toString();
    }
    data['isWoman'] = isWoman.toString();
    return data;
  }

  PersonsModel copyWith(PersonsModel personsModel) {
    return PersonsModel.fromJson(personsModel.toPersonsJson());
  }
}
