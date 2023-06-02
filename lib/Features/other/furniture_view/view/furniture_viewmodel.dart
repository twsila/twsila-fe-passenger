import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/base/baseviewmodel.dart';
import 'package:taxi_for_you/Features/other/furniture_view/view/widgets/first_view/first_view_screen.dart';
import 'package:taxi_for_you/Features/other/furniture_view/view/widgets/second_view/second_view_screen.dart';
import 'package:taxi_for_you/Features/other/furniture_view/view/widgets/third_view/third_view_screen.dart';

import '../../../../app/app_prefs.dart';
import '../../../../app/di.dart';
import '../models/furniture-model.dart';

class FurnitureViewModel extends BaseViewModel {
  FurnitureModel furnitureModel = FurnitureModel();
  final AppPreferences appPreferences = instance<AppPreferences>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = PageController(initialPage: 0);
  ValueNotifier<int> selectedIndex = ValueNotifier(0);
  ValueNotifier<bool> firstScreenValid = ValueNotifier(false);
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

  bool checkObjectIsNull() {
    return !(furnitureModel.furnitureItems.roomsNumber == 0 &&
        furnitureModel.furnitureItems.electricalAppliancesNumber == 0 &&
        furnitureModel.furnitureItems.carpetsNumber == 0 &&
        furnitureModel.furnitureItems.kitchenNumber == 0 &&
        furnitureModel.furnitureItems.airconditionerNumber == 0);
  }
}
