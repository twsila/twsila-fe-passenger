import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/base/baseviewmodel.dart';
import 'package:taxi_for_you/Features/transportation_requests/water_tank_view/views/widgets/first_view/water_first_view.dart';
import 'package:taxi_for_you/Features/transportation_requests/water_tank_view/views/widgets/second_view/water_second_view.dart';
import 'package:taxi_for_you/Features/transportation_requests/water_tank_view/views/widgets/third_view/water_third_view.dart';

import '../../../../app/app_prefs.dart';
import '../../../../app/di.dart';
import '../models/water_model.dart';

class WaterTankViewModel extends BaseViewModel {
  WaterModel waterModel = WaterModel();
  List<String> tankWeights = ["12000", "18000", "24000", "32000"];
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
      WaterFirstView(waterTankViewModel: this),
      WaterSecondView(waterTankViewModel: this),
      WaterThirdView(waterTankViewModel: this),
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
    firstScreenValid.value = waterModel.tankDetails != null;
  }

  bool validateSecondScreen() {
    return waterModel.pickupLocationLatitude != null &&
        waterModel.pickupLocationLongitude != null &&
        waterModel.destinationLocationLatitude != null &&
        waterModel.destinationLocationLongitude != null;
  }
}
