import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../../../core/utils/resources/assets_manager.dart';
import '../../../../../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../../../../../../core/utils/resources/styles_manager.dart';

class ScheduledTimeWidget extends StatelessWidget {
  const ScheduledTimeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: ColorManager.secondaryLightColor,
        border: Border.all(color: ColorManager.secondaryLightColor),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        children: [
          Image.asset(ImageAssets.clock, width: 20, height: 20),
          const SizedBox(width: 4),
          Text(
            AppStrings.scheduledTime.tr(),
            style: getBoldStyle(
                color: ColorManager.primaryTextColor, fontSize: 12),
          )
        ],
      ),
    );
  }
}
