import 'package:taxi_for_you/Features/lookups/model/vehicle_type.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/di.dart';

class LookupModel {
  final List<LookupItem> frozenTypes;
  final List<LookupItem> shippingTypes;
  final List<LookupItem> tankTypes;
  final List<LookupItem> materialTypes;
  final List<LookupItem> packingTypes;
  final List<LookupItem> tankSizes;
  final List<VehicleType> vehicleTypes;

  LookupModel({
    required this.frozenTypes,
    required this.shippingTypes,
    required this.tankTypes,
    required this.materialTypes,
    required this.packingTypes,
    required this.tankSizes,
    required this.vehicleTypes,
  });

  factory LookupModel.fromJson(Map<String, dynamic> json) {
    LookupModel lookupModel = LookupModel(
      frozenTypes: json[LookupConstants.frozenType]
          .map<LookupItem>((e) => LookupItem.fromJson(e))
          .toList(),
      shippingTypes: json[LookupConstants.shippingType]
          .map<LookupItem>((e) => LookupItem.fromJson(e))
          .toList(),
      tankTypes: json[LookupConstants.tankType]
          .map<LookupItem>((e) => LookupItem.fromJson(e))
          .toList(),
      tankSizes: json[LookupConstants.tankSize]
          .map<LookupItem>((e) => LookupItem.fromJson(e))
          .toList(),
      vehicleTypes: json[LookupConstants.vehicleType]
          .map<VehicleType>((e) => VehicleType.fromJson(e))
          .toList(),
      materialTypes: json[LookupConstants.materialType]
          .map<LookupItem>((e) => LookupItem.fromJson(e))
          .toList(),
      packingTypes: json[LookupConstants.packingType]
          .map<LookupItem>((e) => LookupItem.fromJson(e))
          .toList(),
    );
    return lookupModel;
  }
}

class LookupItem {
  final int id;
  final String value;
  final String valueAr;

  LookupItem({
    required this.id,
    required this.value,
    required this.valueAr,
  });

  factory LookupItem.fromJson(Map<String, dynamic> json) {
    final AppPreferences appPreferences = instance();
    return LookupItem(
      id: json['id'] is String ? int.parse(json['id']) : json['id'],
      value: appPreferences.isEnglish()
          ? json['value'].replaceAll('_', ' ')
          : json['valueAr'].replaceAll('_', ' '),
      valueAr: json['valueAr'].replaceAll('_', ' '),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id.toString();
    data['value'] = value.toString();
    data['valueAr'] = valueAr.toString();
    return data;
  }
}

class LookupConstants {
  static const String shippingType = 'ShippingType';
  static const String tankType = 'TankType';
  static const String vehicleType = 'VehicleType';
  static const String packingType = 'PackingType';
  static const String materialType = 'MaterialType';
  static const String tankSize = 'TankSize';
  static const String tankDetails = 'TankDetails';
  static const String frozenType = 'FrozenType';
}
