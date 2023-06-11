import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/base/baseviewmodel.dart';
import 'package:taxi_for_you/Features/other/car_aid_view/views/widgets/secondView/car_aid_second_view.dart';
import 'package:taxi_for_you/Features/other/car_aid_view/views/widgets/thirdView/car_aid_third_view.dart';

import '../../../../app/app_prefs.dart';
import '../../../../app/di.dart';
import '../models/car-aid-model.dart';

class CarAidViewModel extends BaseViewModel {
  CarAidModel carAidModel = CarAidModel();
  final AppPreferences appPreferences = instance<AppPreferences>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = PageController(initialPage: 0);
  bool displayLoadingIndicator = false;

  ValueNotifier<int> selectedIndex = ValueNotifier(0);
  ValueNotifier<bool> secondScreenValid = ValueNotifier(false);
  ValueNotifier<bool> thirdScreenValid = ValueNotifier(false);
  late List<Widget> screens;

  @override
  void start() {
    screens = [
      CarAidSecondView(carAidViewModel: this),
      CarAidThirdView(carAidViewModel: this),
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

  bool validateSecondScreen() {
    return carAidModel.pickupLocationLatitude != null &&
        carAidModel.pickupLocationLongitude != null &&
        carAidModel.destinationLocationLatitude != null &&
        carAidModel.destinationLocationLongitude != null;
  }
}
