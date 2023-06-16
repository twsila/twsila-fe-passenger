import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/base/baseviewmodel.dart';
import 'package:taxi_for_you/Features/transportation_requests/cisterns_view/views/second_view/cisterns_second_view.dart';
import 'package:taxi_for_you/Features/transportation_requests/cisterns_view/views/third_view/cisterns_third_view.dart';

import '../../../../app/app_prefs.dart';
import '../../../../app/di.dart';
import '../models/cisterns_model.dart';
import 'first_view/cisterns_first_view.dart';

class CisternsViewModel extends BaseViewModel {
  CisternsModel cisternsModel = CisternsModel();
  List<String> cisternsTypes = ["نقل مياه غير صالحة للشرب", "شفط مياه صرف صحي"];
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
      CisternsFirstView(cisternsViewModel: this),
      CisternsSecondView(cisternsViewModel: this),
      CisternsThirdView(cisternsViewModel: this),
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
    firstScreenValid.value = cisternsModel.cisternsType != null;
  }

  bool validateSecondScreen() {
    return cisternsModel.pickupLocationLatitude != null &&
        cisternsModel.pickupLocationLongitude != null &&
        cisternsModel.destinationLocationLatitude != null &&
        cisternsModel.destinationLocationLongitude != null;
  }
}
