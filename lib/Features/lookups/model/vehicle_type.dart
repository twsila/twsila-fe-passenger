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

  Map<String, dynamic> toJson() {
    final AppPreferences appPreferences = instance();
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (appPreferences.isEnglish()) {
      data["vehicleType"] = vehicleType;
    } else {
      data["vehicleTypeAr"] = vehicleType;
    }
    Map<String, dynamic> map = {};
    noOfPassengers.forEach((element) {
      map.addAll(element.toJson());
    });
    data["numberOfPassengers"] = [map];
    return data;
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
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['numberOfPassengers'] = noOfPassengers;
    return data;
  }
}
