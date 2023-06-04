import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/common/widgets/custom_bottom_sheet.dart';
import 'package:taxi_for_you/Features/other/common/custom_search_bottomsheet.dart';
import 'package:taxi_for_you/Features/other/furniture_view/view/furniture_viewmodel.dart';

import '../../../../../../../../../core/utils/resources/assets_manager.dart';
import '../../../../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../../../../../core/utils/resources/styles_manager.dart';

class SourcePointWidget extends StatefulWidget {
  final FurnitureViewModel furnitureViewModel;

  const SourcePointWidget({Key? key, required this.furnitureViewModel})
      : super(key: key);
  @override
  _SourcePointWidgetState createState() => _SourcePointWidgetState();
}

class _SourcePointWidgetState extends State<SourcePointWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CustomBottomSheet.displayModalBottomSheetList(
          context: context,
          showCloseButton: false,
          initialChildSize: 0.9,
          customWidget: CustomSearchBottomsheet(
            title: AppStrings.selectStartPoint.tr(),
            onSelectPlace: (lat, long, name) {
              setState(() {
                widget.furnitureViewModel.furnitureModel.sourceLocationString =
                    name;
                widget.furnitureViewModel.furnitureModel
                    .pickupLocationLatitude = lat;
                widget.furnitureViewModel.furnitureModel
                    .pickupLocationLongitude = long;
                widget.furnitureViewModel.secondScreenValid.value =
                    widget.furnitureViewModel.validateSecondScreen();
              });
            },
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: ColorManager.secondaryLightColor),
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        child: Row(
          children: [
            Image.asset(ImageAssets.pin),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                widget.furnitureViewModel.furnitureModel.sourceLocationString ??
                    AppStrings.selectStartPoint.tr(),
                style: getBoldStyle(
                    color: ColorManager.primaryTextColor, fontSize: 16),
              ),
            ),
            widget.furnitureViewModel.furnitureModel.sourceLocationString ==
                    null
                ? Icon(
                    Icons.arrow_forward,
                    color: ColorManager.primary,
                  )
                : Image.asset(ImageAssets.correct)
          ],
        ),
      ),
    );
  }
}
