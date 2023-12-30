import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/di.dart';

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
    final AppPreferences appPreferences = instance();
    return VehicleType(
      id: json["id"],
      vehicleType: appPreferences.isEnglish()
          ? json["vehicleType"]
          : json["vehicleTypeAr"],
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
