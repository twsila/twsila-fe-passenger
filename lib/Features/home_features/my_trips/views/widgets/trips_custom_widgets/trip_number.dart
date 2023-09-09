import 'package:flutter/material.dart';

import '../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../core/utils/resources/styles_manager.dart';

class TripNumberWidget extends StatelessWidget {
  final String tripNumber;
  const TripNumberWidget({
    Key? key,
    required this.tripNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: ColorManager.secondaryLightColor,
        border: Border.all(color: ColorManager.secondaryLightColor),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Text(
        tripNumber,
        style: getBoldStyle(color: ColorManager.primaryTextColor, fontSize: 16),
      ),
    );
  }
}
