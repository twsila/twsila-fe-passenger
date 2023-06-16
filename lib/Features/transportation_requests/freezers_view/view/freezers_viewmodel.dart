import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/base/baseviewmodel.dart';
import 'package:taxi_for_you/Features/transportation_requests/freezers_view/view/widgets/first_view/freezer_first_view.dart';
import 'package:taxi_for_you/Features/transportation_requests/freezers_view/view/widgets/second_view/freezer_second_view.dart';
import 'package:taxi_for_you/Features/transportation_requests/freezers_view/view/widgets/third_view/freezer_third_view.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';

import '../../../../app/app_prefs.dart';
import '../../../../app/di.dart';
import '../models/freezers-model.dart';

class FreezersViewModel extends BaseViewModel {
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

  final AppPreferences appPreferences = instance<AppPreferences>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = PageController(initialPage: 0);
  bool displayLoadingIndicator = false;

  ValueNotifier<int> selectedIndex = ValueNotifier(0);
  ValueNotifier<bool> firstScreenValid = ValueNotifier(false);
  ValueNotifier<bool> secondScreenValid = ValueNotifier(false);
  ValueNotifier<bool> thirdScreenValid = ValueNotifier(false);
  late List<Widget> screens;

  @override
  void start() {
    screens = [
      FreezerFirstView(freezersViewModel: this),
      FreezerSecondView(freezersViewModel: this),
      FreezerThirdView(freezersViewModel: this),
    ];
  }

  @override
  void dispose() {
    controller.dispose();
  }

  handleSteps() {
    if ((selectedIndex.value + 1) < screens.length) {
      controller.animateToPage(
        selectedIndex.value + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  validateFirstScreen() {
    firstScreenValid.value = freezersModel.frozenMaterial != null &&
        freezersModel.shippedType != null;
  }

  bool validateSecondScreen() {
    return freezersModel.pickupLocationLatitude != null &&
        freezersModel.pickupLocationLongitude != null &&
        freezersModel.destinationLocationLatitude != null &&
        freezersModel.destinationLocationLongitude != null;
  }
}
