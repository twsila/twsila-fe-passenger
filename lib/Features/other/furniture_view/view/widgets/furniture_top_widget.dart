import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/other/furniture_view/view/furniture_viewmodel.dart';

import '../../../../../core/utils/resources/assets_manager.dart';
import '../../../../../core/utils/resources/color_manager.dart';
import '../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../core/utils/resources/styles_manager.dart';
import '../../../../common/widgets/custom_back_button.dart';
import '../../../../common/widgets/custom_close_button.dart';

class FurnitureTopWidget extends StatefulWidget {
  final FurnitureViewModel viewModel;

  const FurnitureTopWidget({Key? key, required this.viewModel})
      : super(key: key);
  @override
  _FurnitureTopWidgetState createState() => _FurnitureTopWidgetState();
}

class _FurnitureTopWidgetState extends State<FurnitureTopWidget> {
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
              widget.viewModel.selectedIndex.value == 0
                  ? const CustomCloseButton()
                  : CustomBackButton(
                      onPressed: () =>
                          widget.viewModel.controller.animateToPage(
                        widget.viewModel.selectedIndex.value - 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      ),
                    ),
              Image.asset(ImageAssets.carFurniture),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            AppStrings.step.tr() +
                ' ${widget.viewModel.selectedIndex.value + 1}/${widget.viewModel.screens.length}',
            style: getMediumStyle(
              color: ColorManager.primaryTextColor,
              fontSize: 16,
            ),
          ),
          Text(
            AppStrings.furnitureTransportation.tr(),
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
