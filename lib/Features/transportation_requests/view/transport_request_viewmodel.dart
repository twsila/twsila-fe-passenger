import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_for_you/Features/common/state_renderer/dialogs.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/page_view_widgets/transport_second_view/transport_second_view.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/page_view_widgets/transport_third_view/transport_third_view.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/send_trip_request/send_trip_request_viewmodel.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/car_aid/models/car-aid-model.dart';
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
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/persons/model/persons_model.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/persons/views/persons_first_view.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/persons/views/persons_viewmodel.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/water_tank/models/water_model.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/water_tank/views/water_first_view.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/water_tank/views/water_viewmodel.dart';
import 'package:taxi_for_you/app/constants.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';

import '../../../../app/app_prefs.dart';
import '../../../../app/di.dart';
import '../bloc/transportation_bloc.dart';
import '../bloc/transportation_event.dart';
import '../model/transportation_base_model.dart';

class TransportRequestViewModel {
  final AppPreferences appPreferences = instance<AppPreferences>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late TransportationBaseModel transportationBaseModel;
  late BuildContext context;
  late TransportationBaseModel copyTripModel;
  late Map<String, dynamic> jsonBody;
  bool displayLoadingIndicator = false;
  late bool hasSourceLocation;

  //ViewModels
  final PersonsViewModel personsViewModel = PersonsViewModel();
  final FurnitureViewModel furnitureViewModel = FurnitureViewModel();
  final GoodsViewModel goodsViewModel = GoodsViewModel();
  final FreezersViewModel freezersViewModel = FreezersViewModel();
  final CisternsViewModel cisternsViewModel = CisternsViewModel();
  final WaterTankViewModel waterTankViewModel = WaterTankViewModel();
  final SendTripRequestViewModel viewModel = SendTripRequestViewModel();

  //Screen Controller
  late List<Widget> screens;
  final controller = PageController(initialPage: 0);
  ValueNotifier<int> selectedIndex = ValueNotifier(0);
  ValueNotifier<bool> secondScreenValid = ValueNotifier(false);
  ValueNotifier<bool> thirdScreenValid = ValueNotifier(false);

  void start(
    TransportationBaseModel transportationBaseModel,
    bool hasImages,
    bool hasSourceLocation,
  ) {
    this.transportationBaseModel = transportationBaseModel;
    this.hasSourceLocation = hasSourceLocation;
    copyTripModel = copyWith();
    screens = [
      TransportSecondView(
        transportationBaseModel: transportationBaseModel,
        viewModel: this,
        hasSourceLocation: hasSourceLocation,
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

  cacheOnBack() {
    if (stringModel(copyTripModel) == stringModel(transportationBaseModel)) {
      Navigator.pop(context);
      return;
    }
    ShowDialogHelper.showDialogPopupWithCancel(
      AppStrings.confirmation.tr(),
      AppStrings.saveTrip.tr(),
      context,
      () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
      () async {
        FocusScope.of(context).unfocus();
        inspect(transportationBaseModel);
        viewModel.sendRequest(
            transportationBaseModel, TripStatusConstants.draft);
        BlocProvider.of<TransportationBloc>(context).add(
          SendTransportationRequest(
            transportationBaseModel: transportationBaseModel,
            files: transportationBaseModel.images,
            body: viewModel.jsonBody,
          ),
        );
        Navigator.pop(context);
      },
      cancelText: AppStrings.no.tr(),
    );
  }

  checkScreen() {
    if (transportationBaseModel is PersonsModel) {
      screens.insert(
        0,
        PersonsFirstView(
          personsModel: transportationBaseModel as PersonsModel,
          viewModel: this,
        ),
      );
    } else if (transportationBaseModel is FurnitureModel) {
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
    if (!hasSourceLocation) {
      return transportationBaseModel.destinationLocation.locationName != null;
    }
    return transportationBaseModel.pickupLocation.locationName != null &&
        transportationBaseModel.destinationLocation.locationName != null;
  }

  TransportationBaseModel copyWith() {
    var dynamicType = transportationBaseModel;
    if (dynamicType is PersonsModel) {
      return dynamicType.copyWith(dynamicType);
    } else if (dynamicType is FurnitureModel) {
      return dynamicType.copyWith(dynamicType);
    } else if (dynamicType is GoodsModel) {
      return dynamicType.copyWith(dynamicType);
    } else if (dynamicType is WaterModel) {
      return dynamicType.copyWith(dynamicType);
    } else if (dynamicType is CisternsModel) {
      return dynamicType.copyWith(dynamicType);
    } else if (dynamicType is CarAidModel) {
      return dynamicType.copyWith(dynamicType);
    } else if (dynamicType is FreezersModel) {
      return dynamicType.copyWith(dynamicType);
    }
    return transportationBaseModel;
  }

  String stringModel(TransportationBaseModel transportationBaseModel) {
    if (transportationBaseModel is PersonsModel) {
      return transportationBaseModel.toPersonsJson().toString();
    } else if (transportationBaseModel is FurnitureModel) {
      return transportationBaseModel.toFurnitureJson().toString();
    } else if (transportationBaseModel is GoodsModel) {
      return transportationBaseModel.toGoodsJson().toString();
    } else if (transportationBaseModel is WaterModel) {
      return transportationBaseModel.toWaterJson().toString();
    } else if (transportationBaseModel is CisternsModel) {
      return transportationBaseModel.toCisternsJson().toString();
    } else if (transportationBaseModel is CarAidModel) {
      return transportationBaseModel.toCarAidJson().toString();
    } else if (transportationBaseModel is FreezersModel) {
      return transportationBaseModel.toFreezersJson().toString();
    }
    return '';
  }
}
