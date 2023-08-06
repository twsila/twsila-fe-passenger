import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/core/utils/resources/assets_manager.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';
import 'package:taxi_for_you/core/utils/resources/styles_manager.dart';

class TripStatusCompleted extends StatelessWidget {
  const TripStatusCompleted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: ColorManager.green,
      child: Row(
        children: [
          Image.asset(ImageAssets.tripFinished),
          const SizedBox(width: 16),
          Text(
            AppStrings.tripFinished.tr(),
            style: getMediumStyle(color: Colors.white, fontSize: 16),
          )
        ],
      ),
    );
  }
}
