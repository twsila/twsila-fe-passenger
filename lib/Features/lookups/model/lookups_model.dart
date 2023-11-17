import 'package:taxi_for_you/app/di.dart';

class LookupsModel {
  final List<LookupModel> lookupModel;

  LookupsModel({
    required this.lookupModel,
  });

  static saveLookups(List<dynamic> json) {
    LookupsModel lookupsModel = LookupsModel(
      lookupModel:
          List<LookupModel>.from(json.map((x) => LookupModel.fromJson(x))),
    );

    initLookupsModule(lookupsModel);
  }
}

class LookupModel {
  final int id;
  final String lookupKey;
  final List<LookupItem> lookupJson;
  final String language;

  LookupModel({
    required this.id,
    required this.lookupKey,
    required this.lookupJson,
    required this.language,
  });

  factory LookupModel.fromJson(Map<String, dynamic> json) {
    return LookupModel(
      id: json['id'],
      lookupKey: json['lookupKey'],
      lookupJson: json['lookupJson']
          .map<LookupItem>((e) => LookupItem.fromJson(e))
          .toList(),
      language: json['language'],
    );
  }
}

class LookupItem {
  final int id;
  final String value;

  LookupItem({
    required this.id,
    required this.value,
  });

  factory LookupItem.fromJson(Map<String, dynamic> json) {
    return LookupItem(
      id: json['id'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id.toString();
    data['value'] = value;
    return data;
  }
}

class LookupConstants {
  static const String acceptanceType = 'AcceptanceType';
  static const String driverServiceType = 'DriverServiceType';
  static const String notificationType = 'NotificationType';
  static const String registrationStatus = 'RegistrationStatus';
  static const String shippingType = 'ShippingType';
  static const String submitStatus = 'SubmitStatus';
  static const String tripStatus = 'TripStatus';
  static const String tankType = 'TankType';
  static const String tripModelType = 'TripModelType';
  static const String serviceType = 'ServiceType';
  static const String cancelledByEnum = 'CancelledByEnum';
  static const String vehicleType = 'VehicleType';
  static const String vehicleEntity = 'VehicleEntity';
  static const String bus = 'Bus';
  static const String sedan = 'Sedan';
  static const String packingType = 'PackingType';
  static const String materialType = 'MaterialType';
  static const String tankDetails = 'TankDetails';
  static const String frozenType = 'FrozenType';
  static const String driverStatus = 'DriverStatus';
  static const String driverAcquisition = 'DriverAcquisition';
}
