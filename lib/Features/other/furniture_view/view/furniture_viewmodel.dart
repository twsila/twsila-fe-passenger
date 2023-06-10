import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/base/baseviewmodel.dart';
import 'package:taxi_for_you/Features/other/furniture_view/view/widgets/first_view/furniture_first_view.dart';
import 'package:taxi_for_you/Features/other/furniture_view/view/widgets/second_view/furniture_second_view.dart';
import 'package:taxi_for_you/Features/other/furniture_view/view/widgets/third_view/furniture_third_view.dart';

import '../../../../app/app_prefs.dart';
import '../../../../app/di.dart';
import '../models/furniture_model.dart';

class FurnitureViewModel extends BaseViewModel {
  FurnitureModel furnitureModel = FurnitureModel();
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
      FurnitureFirstView(furnitureViewModel: this),
      FurnitureSecondView(furnitureViewModel: this),
      FurnitureThirdView(furnitureViewModel: this),
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

  bool validateFirstScreen() {
    return !(furnitureModel.furnitureItems.roomsNumber == 0 &&
        furnitureModel.furnitureItems.fridgeNumber == 0 &&
        furnitureModel.furnitureItems.sofaSetNumber == 0 &&
        furnitureModel.furnitureItems.carpetNumber == 0 &&
        furnitureModel.furnitureItems.windowAirconditionerNumber == 0 &&
        furnitureModel.furnitureItems.splitAirconditionerNumber == 0 &&
        furnitureModel.furnitureItems.kitchenNumber == 0 &&
        furnitureModel.furnitureItems.tablesNumber == 0 &&
        furnitureModel.furnitureItems.diningRoomNumber == 0 &&
        furnitureModel.furnitureItems.other == 0);
  }

  bool validateSecondScreen() {
    return furnitureModel.pickupLocationLatitude != null &&
        furnitureModel.pickupLocationLongitude != null &&
        furnitureModel.destinationLocationLatitude != null &&
        furnitureModel.destinationLocationLongitude != null;
  }
}
