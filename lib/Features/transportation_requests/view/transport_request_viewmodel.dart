import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/page_view_widgets/transport_second_view/transport_second_view.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/page_view_widgets/transport_third_view/transport_third_view.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/cisterns/models/cisterns_model.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/cisterns/view/cisterns_first_view.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/cisterns/view/cisterns_viewmodel.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/freezers/models/freezers-model.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/freezers/views/freezer_first_view.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/freezers/views/freezers_viewmodel.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/furniture/models/furniture_model.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/furniture/view/furniture_first_view.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/furniture/view/furniture_viewmodel.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/goods/models/goods_model.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/goods/views/goods_first_view.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/goods/views/goods_viewmodel.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/water_tank/models/water_model.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/water_tank/views/water_first_view.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/water_tank/views/water_viewmodel.dart';

import '../../../../app/app_prefs.dart';
import '../../../../app/di.dart';
import '../model/transportation_base_model.dart';

class TransportRequestViewModel {
  final AppPreferences appPreferences = instance<AppPreferences>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late TransportationBaseModel transportationBaseModel;
  bool displayLoadingIndicator = false;

  //ViewModels
  final FurnitureViewModel furnitureViewModel = FurnitureViewModel();
  final GoodsViewModel goodsViewModel = GoodsViewModel();
  final FreezersViewModel freezersViewModel = FreezersViewModel();
  final CisternsViewModel cisternsViewModel = CisternsViewModel();
  final WaterTankViewModel waterTankViewModel = WaterTankViewModel();

  //Screen Controller
  late List<Widget> screens;
  final controller = PageController(initialPage: 0);
  ValueNotifier<int> selectedIndex = ValueNotifier(0);
  ValueNotifier<bool> secondScreenValid = ValueNotifier(false);
  ValueNotifier<bool> thirdScreenValid = ValueNotifier(false);

  void start(TransportationBaseModel transportationBaseModel, bool hasImages) {
    this.transportationBaseModel = transportationBaseModel;
    screens = [
      TransportSecondView(
        transportationBaseModel: transportationBaseModel,
        viewModel: this,
      ),
      TransportThirdView(
        transportationBaseModel: transportationBaseModel,
        viewModel: this,
        hasImages: hasImages,
      ),
    ];
    checkScreen();
  }

  void dispose() {
    controller.dispose();
  }

  checkScreen() {
    if (transportationBaseModel is FurnitureModel) {
      screens.insert(
        0,
        FurnitureFirstView(
          furnitureModel: transportationBaseModel as FurnitureModel,
          viewModel: this,
        ),
      );
    } else if (transportationBaseModel is GoodsModel) {
      screens.insert(
        0,
        GoodsFirstView(
          goodsModel: transportationBaseModel as GoodsModel,
          viewModel: this,
        ),
      );
    } else if (transportationBaseModel is WaterModel) {
      screens.insert(
        0,
        WaterFirstView(
          waterModel: transportationBaseModel as WaterModel,
          viewModel: this,
        ),
      );
    } else if (transportationBaseModel is FreezersModel) {
      screens.insert(
        0,
        FreezerFirstView(
          freezersModel: transportationBaseModel as FreezersModel,
          viewModel: this,
        ),
      );
    } else if (transportationBaseModel is CisternsModel) {
      screens.insert(
        0,
        CisternsFirstView(
          cisternsModel: transportationBaseModel as CisternsModel,
          viewModel: this,
        ),
      );
    }
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
    return transportationBaseModel.pickupLocation.locationName != null &&
        transportationBaseModel.destinationLocation.locationName != null;
  }
}
