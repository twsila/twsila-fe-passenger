import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/furniture/models/furniture_model.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/furniture/view/furniture_viewmodel.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';
import 'package:taxi_for_you/core/utils/resources/styles_manager.dart';

import '../../../../../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../../../common/widgets/custom_counter_widget.dart';

class FurnitureFirstViewNumbersWidget extends StatefulWidget {
  final FurnitureViewModel viewModel;

  const FurnitureFirstViewNumbersWidget({
    Key? key,
    required this.viewModel,
  }) : super(key: key);
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
          value: widget.viewModel.furnitureModel.furnitureItems.roomsNumber,
          onPlusPressed: () {
            setState(() {
              widget.viewModel.furnitureModel.furnitureItems.roomsNumber =
                  widget.viewModel.furnitureModel.furnitureItems.roomsNumber +
                      1;
            });
            widget.viewModel.firstScreenValid.value = true;
          },
          onMinusPressed: () {
            setState(() {
              widget.viewModel.furnitureModel.furnitureItems.roomsNumber =
                  (widget.viewModel.furnitureModel.furnitureItems.roomsNumber) -
                      1;
              widget.viewModel.firstScreenValid.value =
                  widget.viewModel.validateFirstScreen();
            });
          },
        ),
        CustomCounterWidget(
          text: AppStrings.fridgeNumber.tr(),
          value: widget.viewModel.furnitureModel.furnitureItems.fridgeNumber,
          onPlusPressed: () {
            setState(() {
              widget.viewModel.furnitureModel.furnitureItems.fridgeNumber =
                  widget.viewModel.furnitureModel.furnitureItems.fridgeNumber +
                      1;

              widget.viewModel.firstScreenValid.value = true;
            });
          },
          onMinusPressed: () {
            setState(() {
              widget.viewModel.furnitureModel.furnitureItems.fridgeNumber =
                  widget.viewModel.furnitureModel.furnitureItems.fridgeNumber -
                      1;
              widget.viewModel.firstScreenValid.value =
                  widget.viewModel.validateFirstScreen();
            });
          },
        ),
        CustomCounterWidget(
          text: AppStrings.sofaSetNumber.tr(),
          value: widget.viewModel.furnitureModel.furnitureItems.sofaSetNumber,
          onPlusPressed: () {
            setState(() {
              widget.viewModel.furnitureModel.furnitureItems.sofaSetNumber =
                  widget.viewModel.furnitureModel.furnitureItems.sofaSetNumber +
                      1;

              widget.viewModel.firstScreenValid.value = true;
            });
          },
          onMinusPressed: () {
            setState(() {
              widget.viewModel.furnitureModel.furnitureItems.sofaSetNumber =
                  widget.viewModel.furnitureModel.furnitureItems.sofaSetNumber -
                      1;
              widget.viewModel.firstScreenValid.value =
                  widget.viewModel.validateFirstScreen();
            });
          },
        ),
        CustomCounterWidget(
          text: AppStrings.carpetsNumber.tr(),
          value: widget.viewModel.furnitureModel.furnitureItems.carpetNumber,
          onPlusPressed: () {
            setState(() {
              widget.viewModel.furnitureModel.furnitureItems.carpetNumber =
                  widget.viewModel.furnitureModel.furnitureItems.carpetNumber +
                      1;

              widget.viewModel.firstScreenValid.value = true;
            });
          },
          onMinusPressed: () {
            setState(() {
              widget.viewModel.furnitureModel.furnitureItems.carpetNumber =
                  widget.viewModel.furnitureModel.furnitureItems.carpetNumber -
                      1;
              widget.viewModel.firstScreenValid.value =
                  widget.viewModel.validateFirstScreen();
            });
          },
        ),
        CustomCounterWidget(
          text: AppStrings.windowAirconditionerNumber.tr(),
          value: widget.viewModel.furnitureModel.furnitureItems
              .windowAirconditionerNumber,
          onPlusPressed: () {
            setState(() {
              widget.viewModel.furnitureModel.furnitureItems
                  .windowAirconditionerNumber = widget.viewModel.furnitureModel
                      .furnitureItems.windowAirconditionerNumber +
                  1;
              widget.viewModel.firstScreenValid.value = true;
            });
          },
          onMinusPressed: () {
            setState(() {
              widget.viewModel.furnitureModel.furnitureItems
                  .windowAirconditionerNumber = widget.viewModel.furnitureModel
                      .furnitureItems.windowAirconditionerNumber -
                  1;
              widget.viewModel.firstScreenValid.value =
                  widget.viewModel.validateFirstScreen();
            });
          },
        ),
        CustomCounterWidget(
          text: AppStrings.splitAirconditionerNumber.tr(),
          value: widget.viewModel.furnitureModel.furnitureItems
              .splitAirconditionerNumber,
          onPlusPressed: () {
            setState(() {
              widget.viewModel.furnitureModel.furnitureItems
                  .splitAirconditionerNumber = widget.viewModel.furnitureModel
                      .furnitureItems.splitAirconditionerNumber +
                  1;
              widget.viewModel.firstScreenValid.value = true;
            });
          },
          onMinusPressed: () {
            setState(() {
              widget.viewModel.furnitureModel.furnitureItems
                  .splitAirconditionerNumber = widget.viewModel.furnitureModel
                      .furnitureItems.splitAirconditionerNumber -
                  1;
              widget.viewModel.firstScreenValid.value =
                  widget.viewModel.validateFirstScreen();
            });
          },
        ),
        CustomCounterWidget(
          text: AppStrings.kitchenNumber.tr(),
          value: widget.viewModel.furnitureModel.furnitureItems.kitchenNumber,
          onPlusPressed: () {
            setState(() {
              widget.viewModel.furnitureModel.furnitureItems.kitchenNumber =
                  widget.viewModel.furnitureModel.furnitureItems.kitchenNumber +
                      1;

              widget.viewModel.firstScreenValid.value = true;
            });
          },
          onMinusPressed: () {
            setState(() {
              widget.viewModel.furnitureModel.furnitureItems.kitchenNumber =
                  widget.viewModel.furnitureModel.furnitureItems.kitchenNumber -
                      1;
              widget.viewModel.firstScreenValid.value =
                  widget.viewModel.validateFirstScreen();
            });
          },
        ),
        CustomCounterWidget(
          text: AppStrings.tablesNumber.tr(),
          value: widget.viewModel.furnitureModel.furnitureItems.tablesNumber,
          onPlusPressed: () {
            setState(() {
              widget.viewModel.furnitureModel.furnitureItems.tablesNumber =
                  widget.viewModel.furnitureModel.furnitureItems.tablesNumber +
                      1;

              widget.viewModel.firstScreenValid.value = true;
            });
          },
          onMinusPressed: () {
            setState(() {
              widget.viewModel.furnitureModel.furnitureItems.tablesNumber =
                  widget.viewModel.furnitureModel.furnitureItems.tablesNumber -
                      1;
              widget.viewModel.firstScreenValid.value =
                  widget.viewModel.validateFirstScreen();
            });
          },
        ),
        CustomCounterWidget(
          text: AppStrings.dinningRoomsNumber.tr(),
          value:
              widget.viewModel.furnitureModel.furnitureItems.diningRoomNumber,
          onPlusPressed: () {
            setState(() {
              widget.viewModel.furnitureModel.furnitureItems.diningRoomNumber =
                  widget.viewModel.furnitureModel.furnitureItems
                          .diningRoomNumber +
                      1;

              widget.viewModel.firstScreenValid.value = true;
            });
          },
          onMinusPressed: () {
            setState(() {
              widget.viewModel.furnitureModel.furnitureItems.diningRoomNumber =
                  widget.viewModel.furnitureModel.furnitureItems
                          .diningRoomNumber -
                      1;
              widget.viewModel.firstScreenValid.value =
                  widget.viewModel.validateFirstScreen();
            });
          },
        ),
        CustomCounterWidget(
          text: AppStrings.other.tr(),
          value: widget.viewModel.furnitureModel.furnitureItems.other,
          onPlusPressed: () {
            setState(() {
              widget.viewModel.furnitureModel.furnitureItems.other =
                  widget.viewModel.furnitureModel.furnitureItems.other + 1;

              widget.viewModel.firstScreenValid.value = true;
            });
          },
          onMinusPressed: () {
            setState(() {
              widget.viewModel.furnitureModel.furnitureItems.other =
                  widget.viewModel.furnitureModel.furnitureItems.other - 1;
              widget.viewModel.firstScreenValid.value =
                  widget.viewModel.validateFirstScreen();
            });
          },
        ),
      ],
    );
  }
}
