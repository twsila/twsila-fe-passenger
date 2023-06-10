import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/base/baseviewmodel.dart';
import 'package:taxi_for_you/Features/other/goods_view/views/widgets/firstView/goods_first_view.dart';
import 'package:taxi_for_you/Features/other/goods_view/views/widgets/secondView/goods_second_view.dart';
import 'package:taxi_for_you/Features/other/goods_view/views/widgets/thirdView/goods_third_view.dart';

import '../../../../app/app_prefs.dart';
import '../../../../app/di.dart';
import '../models/goods_model.dart';

class GoodsViewModel extends BaseViewModel {
  GoodsModel goodsModel = GoodsModel();
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
      GoodsFirstView(goodsViewModel: this),
      GoodsSecondView(goodsViewModel: this),
      GoodsThirdView(goodsViewModel: this),
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
    return goodsModel.pickupLocationLatitude != null &&
        goodsModel.pickupLocationLongitude != null &&
        goodsModel.destinationLocationLatitude != null &&
        goodsModel.destinationLocationLongitude != null;
  }
}
