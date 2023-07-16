import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/core/utils/ext/screen_size_ext.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';

import '../../../../../../core/utils/resources/assets_manager.dart';
import '../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../core/utils/resources/styles_manager.dart';

class TripNoOffers extends StatelessWidget {
  const TripNoOffers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: context.getHeight() / 3,
          child: Image.asset(ImageAssets.driverWaiting),
        ),
        Text(
          AppStrings.waitingOffers.tr(),
          style: getBoldStyle(
            color: ColorManager.black,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
