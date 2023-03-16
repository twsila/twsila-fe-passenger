import 'package:easy_localization/easy_localization.dart';
import 'package:taxi_for_you/domain/model/freezers-model.dart';
import 'package:taxi_for_you/utils/resources/strings_manager.dart';

class FreezersViewModel {
  FreezersModel freezersModel = FreezersModel();

  List<String> shippingTypes = [
    AppStrings.chiller.tr(),
    AppStrings.frozen.tr(),
    AppStrings.dry.tr(),
  ];
  List<String> materialsTobeShipped = [
    AppStrings.meat_poultry_fish.tr(),
    AppStrings.vegetables.tr(),
    AppStrings.foodStuffs.tr(),
    AppStrings.flowers_plants.tr(),
    AppStrings.other.tr()
  ];
}
