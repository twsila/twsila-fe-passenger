import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/transportation_requests/furniture_view/view/furniture_viewmodel.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';
import 'package:taxi_for_you/core/utils/resources/styles_manager.dart';

import '../../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../../common/widgets/custom_counter_widget.dart';

class FurnitureFirstViewNumbersWidget extends StatefulWidget {
  final FurnitureViewModel furnitureViewModel;

  const FurnitureFirstViewNumbersWidget(
      {Key? key, required this.furnitureViewModel})
      : super(key: key);
  @override
  _FurnitureFirstViewNumbersWidgetState createState() =>
      _FurnitureFirstViewNumbersWidgetState();
}

class _FurnitureFirstViewNumbersWidgetState
    extends State<FurnitureFirstViewNumbersWidget> {
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
          text: AppStrings.roomsNumber.tr(),
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
                  widget.furnitureViewModel.validateFirstScreen();
            });
          },
        ),
        CustomCounterWidget(
          text: AppStrings.fridgeNumber.tr(),
          value: widget
              .furnitureViewModel.furnitureModel.furnitureItems.fridgeNumber,
          onPlusPressed: () {
            setState(() {
              widget.furnitureViewModel.furnitureModel.furnitureItems
                  .fridgeNumber = widget.furnitureViewModel.furnitureModel
                      .furnitureItems.fridgeNumber +
                  1;

              widget.furnitureViewModel.firstScreenValid.value = true;
            });
          },
          onMinusPressed: () {
            setState(() {
              widget.furnitureViewModel.furnitureModel.furnitureItems
                  .fridgeNumber = widget.furnitureViewModel.furnitureModel
                      .furnitureItems.fridgeNumber -
                  1;
              widget.furnitureViewModel.firstScreenValid.value =
                  widget.furnitureViewModel.validateFirstScreen();
            });
          },
        ),
        CustomCounterWidget(
          text: AppStrings.sofaSetNumber.tr(),
          value: widget
              .furnitureViewModel.furnitureModel.furnitureItems.sofaSetNumber,
          onPlusPressed: () {
            setState(() {
              widget.furnitureViewModel.furnitureModel.furnitureItems
                  .sofaSetNumber = widget.furnitureViewModel.furnitureModel
                      .furnitureItems.sofaSetNumber +
                  1;

              widget.furnitureViewModel.firstScreenValid.value = true;
            });
          },
          onMinusPressed: () {
            setState(() {
              widget.furnitureViewModel.furnitureModel.furnitureItems
                  .sofaSetNumber = widget.furnitureViewModel.furnitureModel
                      .furnitureItems.sofaSetNumber -
                  1;
              widget.furnitureViewModel.firstScreenValid.value =
                  widget.furnitureViewModel.validateFirstScreen();
            });
          },
        ),
        CustomCounterWidget(
          text: AppStrings.carpetsNumber.tr(),
          value: widget
              .furnitureViewModel.furnitureModel.furnitureItems.carpetNumber,
          onPlusPressed: () {
            setState(() {
              widget.furnitureViewModel.furnitureModel.furnitureItems
                  .carpetNumber = widget.furnitureViewModel.furnitureModel
                      .furnitureItems.carpetNumber +
                  1;

              widget.furnitureViewModel.firstScreenValid.value = true;
            });
          },
          onMinusPressed: () {
            setState(() {
              widget.furnitureViewModel.furnitureModel.furnitureItems
                  .carpetNumber = widget.furnitureViewModel.furnitureModel
                      .furnitureItems.carpetNumber -
                  1;
              widget.furnitureViewModel.firstScreenValid.value =
                  widget.furnitureViewModel.validateFirstScreen();
            });
          },
        ),
        CustomCounterWidget(
          text: AppStrings.windowAirconditionerNumber.tr(),
          value: widget.furnitureViewModel.furnitureModel.furnitureItems
              .windowAirconditionerNumber,
          onPlusPressed: () {
            setState(() {
              widget.furnitureViewModel.furnitureModel.furnitureItems
                  .windowAirconditionerNumber = widget
                      .furnitureViewModel
                      .furnitureModel
                      .furnitureItems
                      .windowAirconditionerNumber +
                  1;
              widget.furnitureViewModel.firstScreenValid.value = true;
            });
          },
          onMinusPressed: () {
            setState(() {
              widget.furnitureViewModel.furnitureModel.furnitureItems
                  .windowAirconditionerNumber = widget
                      .furnitureViewModel
                      .furnitureModel
                      .furnitureItems
                      .windowAirconditionerNumber -
                  1;
              widget.furnitureViewModel.firstScreenValid.value =
                  widget.furnitureViewModel.validateFirstScreen();
            });
          },
        ),
        CustomCounterWidget(
          text: AppStrings.splitAirconditionerNumber.tr(),
          value: widget.furnitureViewModel.furnitureModel.furnitureItems
              .splitAirconditionerNumber,
          onPlusPressed: () {
            setState(() {
              widget.furnitureViewModel.furnitureModel.furnitureItems
                  .splitAirconditionerNumber = widget.furnitureViewModel
                      .furnitureModel.furnitureItems.splitAirconditionerNumber +
                  1;
              widget.furnitureViewModel.firstScreenValid.value = true;
            });
          },
          onMinusPressed: () {
            setState(() {
              widget.furnitureViewModel.furnitureModel.furnitureItems
                  .splitAirconditionerNumber = widget.furnitureViewModel
                      .furnitureModel.furnitureItems.splitAirconditionerNumber -
                  1;
              widget.furnitureViewModel.firstScreenValid.value =
                  widget.furnitureViewModel.validateFirstScreen();
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
                  widget.furnitureViewModel.validateFirstScreen();
            });
          },
        ),
        CustomCounterWidget(
          text: AppStrings.tablesNumber.tr(),
          value: widget
              .furnitureViewModel.furnitureModel.furnitureItems.tablesNumber,
          onPlusPressed: () {
            setState(() {
              widget.furnitureViewModel.furnitureModel.furnitureItems
                  .tablesNumber = widget.furnitureViewModel.furnitureModel
                      .furnitureItems.tablesNumber +
                  1;

              widget.furnitureViewModel.firstScreenValid.value = true;
            });
          },
          onMinusPressed: () {
            setState(() {
              widget.furnitureViewModel.furnitureModel.furnitureItems
                  .tablesNumber = widget.furnitureViewModel.furnitureModel
                      .furnitureItems.tablesNumber -
                  1;
              widget.furnitureViewModel.firstScreenValid.value =
                  widget.furnitureViewModel.validateFirstScreen();
            });
          },
        ),
        CustomCounterWidget(
          text: AppStrings.dinningRoomsNumber.tr(),
          value: widget.furnitureViewModel.furnitureModel.furnitureItems
              .diningRoomNumber,
          onPlusPressed: () {
            setState(() {
              widget.furnitureViewModel.furnitureModel.furnitureItems
                  .diningRoomNumber = widget.furnitureViewModel.furnitureModel
                      .furnitureItems.diningRoomNumber +
                  1;

              widget.furnitureViewModel.firstScreenValid.value = true;
            });
          },
          onMinusPressed: () {
            setState(() {
              widget.furnitureViewModel.furnitureModel.furnitureItems
                  .diningRoomNumber = widget.furnitureViewModel.furnitureModel
                      .furnitureItems.diningRoomNumber -
                  1;
              widget.furnitureViewModel.firstScreenValid.value =
                  widget.furnitureViewModel.validateFirstScreen();
            });
          },
        ),
        CustomCounterWidget(
          text: AppStrings.other.tr(),
          value: widget.furnitureViewModel.furnitureModel.furnitureItems.other,
          onPlusPressed: () {
            setState(() {
              widget.furnitureViewModel.furnitureModel.furnitureItems.other =
                  widget.furnitureViewModel.furnitureModel.furnitureItems
                          .other +
                      1;

              widget.furnitureViewModel.firstScreenValid.value = true;
            });
          },
          onMinusPressed: () {
            setState(() {
              widget.furnitureViewModel.furnitureModel.furnitureItems.other =
                  widget.furnitureViewModel.furnitureModel.furnitureItems
                          .other -
                      1;
              widget.furnitureViewModel.firstScreenValid.value =
                  widget.furnitureViewModel.validateFirstScreen();
            });
          },
        ),
      ],
    );
  }
}
