import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/di.dart';

class VehicleTypes {
  static final AppPreferences appPreferences = instance();
  final List<VehicleType> vehicleType;

  VehicleTypes({
    required this.vehicleType,
  });

  static saveVehicle(List<dynamic> json) {
    VehicleTypes vehicleTypes = VehicleTypes(
      vehicleType: List<VehicleType>.from(appPreferences.isEnglish()
          ? json[0]['lookupJson'].map(
              (x) => VehicleType.fromJson(x),
            )
          : json[1]['lookupJson'].map(
              (x) => VehicleType.fromJson(x),
            )),
    );

    initVehicleModule(vehicleTypes);
  }
}

class VehicleType {
  final int id;
  final String vehicleType;
  final List<NoOfPassengers> noOfPassengers;

  VehicleType({
    required this.id,
    required this.vehicleType,
    required this.noOfPassengers,
  });

  factory VehicleType.fromJson(Map<String, dynamic> json) {
    return VehicleType(
      id: json["id"],
      vehicleType: json["vehicleType"],
      noOfPassengers: json['numberOfPassengers'].isEmpty
          ? []
          : json['numberOfPassengers']
              .map<NoOfPassengers>((e) => NoOfPassengers.fromJson(e))
              .toList(),
    );
  }
}

class NoOfPassengers {
  final int id;
  final int noOfPassengers;

  NoOfPassengers({
    required this.id,
    required this.noOfPassengers,
  });

  factory NoOfPassengers.fromJson(Map<String, dynamic> json) {
    return NoOfPassengers(
      id: json["id"],
      noOfPassengers: json["numberOfPassengers"],
    );
  }
}
