import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/other/furniture_view/view/furniture_viewmodel.dart';

import '../../../../../../../../../core/utils/resources/assets_manager.dart';
import '../../../../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../../../../../core/utils/resources/styles_manager.dart';
import '../../../../../../../../common/widgets/custom_bottom_sheet.dart';
import '../../../../../../../common/custom_search_bottomsheet.dart';

class DestinationPointWidget extends StatefulWidget {
  final FurnitureViewModel furnitureViewModel;

  const DestinationPointWidget({Key? key, required this.furnitureViewModel})
      : super(key: key);
  @override
  _DestinationPointWidgetState createState() => _DestinationPointWidgetState();
}

class _DestinationPointWidgetState extends State<DestinationPointWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CustomBottomSheet.displayModalBottomSheetList(
          context: context,
          showCloseButton: false,
          initialChildSize: 0.9,
          customWidget: CustomSearchBottomsheet(
            title: AppStrings.selectDeliveryPoint.tr(),
            onSelectPlace: (lat, long, name) {
              setState(() {
                widget.furnitureViewModel.furnitureModel
                    .destinationLocationString = name;
                widget.furnitureViewModel.furnitureModel
                    .destinationLocationLatitude = lat;
                widget.furnitureViewModel.furnitureModel
                    .destinationLocationLongitude = long;
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
                widget.furnitureViewModel.furnitureModel
                        .destinationLocationString ??
                    AppStrings.selectDeliveryPoint.tr(),
                style: getBoldStyle(
                    color: ColorManager.primaryTextColor, fontSize: 16),
              ),
            ),
            widget.furnitureViewModel.furnitureModel
                        .destinationLocationString ==
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
