import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/di.dart';

import '../../../core/utils/resources/langauge_manager.dart';
import 'models/vehicle_type.dart';

class LookupsModel {
  final List<VehicleType> vehicleTypes;

  LookupsModel({
    required this.vehicleTypes,
  });

  static saveLookups(Map<String, dynamic> json) {
    final AppPreferences appPreferences = instance<AppPreferences>();
    bool isEnglish =
        appPreferences.getAppLanguage() == LanguageType.ENGLISH.getValue();

    var vehicleTypeJson =
        isEnglish ? json['VehicleType'] : json['VehicleTypeAR'];

    LookupsModel lookupsModel = LookupsModel(
      vehicleTypes: List<VehicleType>.from(
        vehicleTypeJson.map(
          (x) => VehicleType.fromJson(x),
        ),
      ),
    );

    initLookupsModule(lookupsModel);
  }
}
