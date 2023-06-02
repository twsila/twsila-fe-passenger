import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/other/furniture_view/view/furniture_viewmodel.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';
import 'package:taxi_for_you/core/utils/resources/styles_manager.dart';

import '../../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../../common/widgets/custom_counter_widget.dart';

class FirstViewNumbersWidget extends StatefulWidget {
  final FurnitureViewModel furnitureViewModel;

  const FirstViewNumbersWidget({Key? key, required this.furnitureViewModel})
      : super(key: key);
  @override
  _FirstViewNumbersWidgetState createState() => _FirstViewNumbersWidgetState();
}

class _FirstViewNumbersWidgetState extends State<FirstViewNumbersWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.transporationItems.tr(),
          textAlign: TextAlign.start,
          style:
              getMediumStyle(color: ColorManager.titlesTextColor, fontSize: 16),
        ),
        CustomCounterWidget(
          text: AppStrings.bedNumber.tr(),
          value: widget
              .furnitureViewModel.furnitureModel.furnitureItems.roomsNumber,
          onPlusPressed: () {
            setState(() {
              widget.furnitureViewModel.furnitureModel.furnitureItems
                  .roomsNumber = widget.furnitureViewModel.furnitureModel
                      .furnitureItems.roomsNumber +
                  1;
            });
            widget.furnitureViewModel.firstScreenValid.value = true;
          },
          onMinusPressed: () {
            setState(() {
              widget.furnitureViewModel.furnitureModel.furnitureItems
                  .roomsNumber = (widget.furnitureViewModel.furnitureModel
                      .furnitureItems.roomsNumber) -
                  1;
              widget.furnitureViewModel.firstScreenValid.value =
                  widget.furnitureViewModel.checkObjectIsNull();
            });
          },
        ),
        CustomCounterWidget(
          text: AppStrings.electricalAppliances.tr(),
          value: widget.furnitureViewModel.furnitureModel.furnitureItems
              .electricalAppliancesNumber,
          onPlusPressed: () {
            setState(() {
              widget.furnitureViewModel.furnitureModel.furnitureItems
                  .electricalAppliancesNumber = widget
                      .furnitureViewModel
                      .furnitureModel
                      .furnitureItems
                      .electricalAppliancesNumber +
                  1;

              widget.furnitureViewModel.firstScreenValid.value = true;
            });
          },
          onMinusPressed: () {
            setState(() {
              widget.furnitureViewModel.furnitureModel.furnitureItems
                  .electricalAppliancesNumber = widget
                      .furnitureViewModel
                      .furnitureModel
                      .furnitureItems
                      .electricalAppliancesNumber -
                  1;
              widget.furnitureViewModel.firstScreenValid.value =
                  widget.furnitureViewModel.checkObjectIsNull();
            });
          },
        ),
        CustomCounterWidget(
          text: AppStrings.carpetsNumber.tr(),
          value: widget
              .furnitureViewModel.furnitureModel.furnitureItems.carpetsNumber,
          onPlusPressed: () {
            setState(() {
              widget.furnitureViewModel.furnitureModel.furnitureItems
                  .carpetsNumber = widget.furnitureViewModel.furnitureModel
                      .furnitureItems.carpetsNumber +
                  1;

              widget.furnitureViewModel.firstScreenValid.value = true;
            });
          },
          onMinusPressed: () {
            setState(() {
              widget.furnitureViewModel.furnitureModel.furnitureItems
                  .carpetsNumber = widget.furnitureViewModel.furnitureModel
                      .furnitureItems.carpetsNumber -
                  1;
              widget.furnitureViewModel.firstScreenValid.value =
                  widget.furnitureViewModel.checkObjectIsNull();
            });
          },
        ),
        CustomCounterWidget(
          text: AppStrings.kitchenNumber.tr(),
          value: widget
              .furnitureViewModel.furnitureModel.furnitureItems.kitchenNumber,
          onPlusPressed: () {
            setState(() {
              widget.furnitureViewModel.furnitureModel.furnitureItems
                  .kitchenNumber = widget.furnitureViewModel.furnitureModel
                      .furnitureItems.kitchenNumber +
                  1;

              widget.furnitureViewModel.firstScreenValid.value = true;
            });
          },
          onMinusPressed: () {
            setState(() {
              widget.furnitureViewModel.furnitureModel.furnitureItems
                  .kitchenNumber = widget.furnitureViewModel.furnitureModel
                      .furnitureItems.kitchenNumber -
                  1;
              widget.furnitureViewModel.firstScreenValid.value =
                  widget.furnitureViewModel.checkObjectIsNull();
            });
          },
        ),
        CustomCounterWidget(
          text: AppStrings.airconditionarNumber.tr(),
          value: widget.furnitureViewModel.furnitureModel.furnitureItems
              .airconditionerNumber,
          onPlusPressed: () {
            setState(() {
              widget.furnitureViewModel.furnitureModel.furnitureItems
                  .airconditionerNumber = widget.furnitureViewModel
                      .furnitureModel.furnitureItems.airconditionerNumber +
                  1;
              widget.furnitureViewModel.firstScreenValid.value = true;
            });
          },
          onMinusPressed: () {
            setState(() {
              widget.furnitureViewModel.furnitureModel.furnitureItems
                  .airconditionerNumber = widget.furnitureViewModel
                      .furnitureModel.furnitureItems.airconditionerNumber -
                  1;
              widget.furnitureViewModel.firstScreenValid.value =
                  widget.furnitureViewModel.checkObjectIsNull();
            });
          },
        ),
      ],
    );
  }
}
