import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/other/furniture_view/view/furniture_viewmodel.dart';

import '../../../../../../../../../app/app_prefs.dart';
import '../../../../../../../../../app/di.dart';
import '../../../../../../../../../core/utils/resources/assets_manager.dart';
import '../../../../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../../../../core/utils/resources/langauge_manager.dart';
import '../../../../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../../../../../core/utils/resources/styles_manager.dart';

class DestinationPointWidget extends StatefulWidget {
  final FurnitureViewModel furnitureViewModel;

  const DestinationPointWidget({Key? key, required this.furnitureViewModel})
      : super(key: key);
  @override
  _DestinationPointWidgetState createState() => _DestinationPointWidgetState();
}

class _DestinationPointWidgetState extends State<DestinationPointWidget> {
  final _appPrefs = instance<AppPreferences>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
                AppStrings.selectDeliveryPoint.tr(),
                style: getBoldStyle(
                    color: ColorManager.primaryTextColor, fontSize: 16),
              ),
            ),
            Icon(
              _appPrefs.getAppLanguage() == LanguageType.ENGLISH.getValue()
                  ? Icons.arrow_back
                  : Icons.arrow_forward,
              color: ColorManager.primary,
            )
          ],
        ),
      ),
    );
  }
}
