import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/other/furniture_view/view/furniture_viewmodel.dart';
import 'package:taxi_for_you/Features/other/furniture_view/view/widgets/second_view/widgets/second_view_location/widgets/destination_point.dart';
import 'package:taxi_for_you/Features/other/furniture_view/view/widgets/second_view/widgets/second_view_location/widgets/source_point.dart';

import '../../../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../../../../core/utils/resources/styles_manager.dart';

class SecondViewLocation extends StatefulWidget {
  final FurnitureViewModel furnitureViewModel;

  const SecondViewLocation({
    Key? key,
    required this.furnitureViewModel,
  }) : super(key: key);
  @override
  _SecondViewLocationState createState() => _SecondViewLocationState();
}

class _SecondViewLocationState extends State<SecondViewLocation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.determinateLocation.tr(),
          style: getMediumStyle(
            color: ColorManager.primaryTextColor,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
        SourcePointWidget(furnitureViewModel: widget.furnitureViewModel),
        const SizedBox(height: 16),
        DestinationPointWidget(furnitureViewModel: widget.furnitureViewModel),
      ],
    );
  }
}
