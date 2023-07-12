import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/transport_request_viewmodel.dart';

import '../../../../../app/constants.dart';
import '../../../../../core/utils/resources/assets_manager.dart';
import '../../../../../core/utils/resources/color_manager.dart';
import '../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../core/utils/resources/styles_manager.dart';
import '../../../../common/widgets/custom_back_button.dart';
import '../../../../common/widgets/custom_close_button.dart';

class TransportationTopWidget extends StatefulWidget {
  final TransportRequestViewModel transportViewModel;

  const TransportationTopWidget({
    Key? key,
    required this.transportViewModel,
  }) : super(key: key);
  @override
  _TransportationTopWidgetState createState() =>
      _TransportationTopWidgetState();
}

class _TransportationTopWidgetState extends State<TransportationTopWidget> {
  String getString(String tripType) {
    if (tripType == TripTypeConstants.furnitureType) {
      return AppStrings.request.tr() +
          ' ' +
          AppStrings.furnitureTransportation.tr();
    } else if (tripType == TripTypeConstants.goodsType) {
      return AppStrings.request.tr() +
          ' ' +
          AppStrings.goodsTransportation.tr();
    } else if (tripType == TripTypeConstants.carAidType) {
      return AppStrings.request.tr() +
          ' ' +
          AppStrings.carAidTransportation.tr();
    } else if (tripType == TripTypeConstants.frozenType) {
      return AppStrings.request.tr() +
          ' ' +
          AppStrings.freezerTransportation.tr();
    } else if (tripType == TripTypeConstants.drinkWaterType) {
      return AppStrings.requestWhite.tr() +
          ' ' +
          AppStrings.waterTankTransportation.tr();
    } else if (tripType == TripTypeConstants.otherTankType) {
      return AppStrings.request.tr() +
          ' ' +
          AppStrings.cisternsTransportation.tr();
    } else {
      return '';
    }
  }

  getImagePath(String tripType) {
    if (tripType == TripTypeConstants.furnitureType) {
      return ImageAssets.carFurniture;
    } else if (tripType == TripTypeConstants.goodsType) {
      return ImageAssets.carGoods;
    } else if (tripType == TripTypeConstants.carAidType) {
      return ImageAssets.carAid;
    } else if (tripType == TripTypeConstants.frozenType) {
      return ImageAssets.carfrozen;
    } else if (tripType == TripTypeConstants.drinkWaterType) {
      return ImageAssets.carDrinkWater;
    } else if (tripType == TripTypeConstants.otherTankType) {
      return ImageAssets.carCisterns;
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.transportViewModel.selectedIndex.value == 0
                  ? CustomCloseButton(
                      onPressed: () => widget.transportViewModel.cacheOnBack(),
                    )
                  : CustomBackButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        widget.transportViewModel.controller.animateToPage(
                          widget.transportViewModel.selectedIndex.value - 1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
              Image.asset(getImagePath(
                  widget.transportViewModel.transportationBaseModel.tripType!)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            AppStrings.step.tr() +
                ' ${widget.transportViewModel.selectedIndex.value + 1}/${widget.transportViewModel.screens.length}',
            style: getMediumStyle(
              color: ColorManager.primaryTextColor,
              fontSize: 16,
            ),
          ),
          Text(
            getString(
                widget.transportViewModel.transportationBaseModel.tripType!),
            style: getBoldStyle(
              color: ColorManager.primaryTextColor,
              fontSize: 24,
            ),
          )
        ],
      ),
    );
  }
}
