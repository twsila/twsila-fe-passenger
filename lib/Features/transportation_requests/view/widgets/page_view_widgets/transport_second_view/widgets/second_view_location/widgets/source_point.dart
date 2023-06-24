import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/common/widgets/custom_bottom_sheet.dart';

import '../../../../../../../../../../../core/utils/resources/assets_manager.dart';
import '../../../../../../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../../../../../../../core/utils/resources/styles_manager.dart';
import '../../../../../custom_widgets/custom_search_bottomsheet.dart';

class SourcePointWidget extends StatefulWidget {
  final Function(String lat, String long, String locationName) onSelectPlace;
  final String? pickupLocationName;

  const SourcePointWidget({
    Key? key,
    required this.onSelectPlace,
    this.pickupLocationName,
  }) : super(key: key);
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
            onSelectPlace: widget.onSelectPlace,
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
                widget.pickupLocationName ?? AppStrings.selectStartPoint.tr(),
                style: getBoldStyle(
                    color: ColorManager.primaryTextColor, fontSize: 16),
              ),
            ),
            const SizedBox(width: 8),
            widget.pickupLocationName == null
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
