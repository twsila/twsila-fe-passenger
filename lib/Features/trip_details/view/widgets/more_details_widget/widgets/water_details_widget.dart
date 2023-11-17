import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/water_tank/models/water_model.dart';

import '../../../../../../core/utils/resources/strings_manager.dart';
import '../item_widget.dart';

class WaterDetailsWidget extends StatelessWidget {
  final WaterModel waterModel;
  const WaterDetailsWidget({
    Key? key,
    required this.waterModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ItemWidget(
          title: AppStrings.waterTankSize.tr(),
          text: waterModel.tankDetails != null
              ? waterModel.tankDetails!.value
              : AppStrings.unknown.tr(),
        ),
      ],
    );
  }
}
