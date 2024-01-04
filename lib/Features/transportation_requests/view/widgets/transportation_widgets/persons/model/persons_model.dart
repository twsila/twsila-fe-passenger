import 'package:taxi_for_you/Features/lookups/model/vehicle_type.dart';

import '../../../../../model/transportation_base_model.dart';

class PersonsModel extends TransportationBaseModel {
  bool isWoman = false;
  VehicleType? vehicleType;
  int? numberOfPassengersId;

  PersonsModel();

  PersonsModel.fromJson(Map<String, dynamic> json) {
    fromJSON(json);
    isWoman = json['isWoman'] == null
        ? false
        : json['isWoman'] is String
            ? json['isWoman'] == 'true'
            : json['isWoman'];
    if (json['vehicleType'] != null) {
      vehicleType = VehicleType.fromJson(json['vehicleType']);
    }
    if (json['numberOfPassengers'] != null) {
      numberOfPassengersId = json['numberOfPassengers']['numberOfPassengers'];
    }
  }

  Map<String, dynamic> toPersonsJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data = toJSON();
    if (vehicleType != null) {
      data['vehicleType'] = vehicleType!.id.toString();
    }
    if (numberOfPassengersId != null) {
      data['numberOfPassengers'] = numberOfPassengersId.toString();
    }
    data['isWoman'] = isWoman.toString();
    return data;
  }

  PersonsModel copyWith(PersonsModel personsModel) {
    return PersonsModel.fromJson(personsModel.toPersonsJson());
  }
}

class NumberOfPassengers {
  int? id;
  int? numberOfPassengers;

  NumberOfPassengers();

  NumberOfPassengers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    numberOfPassengers = json['numberOfPassengers'];
  }
}
