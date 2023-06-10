import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/other/common/pageview_widgets/second_view_location/widgets/destination_point.dart';
import 'package:taxi_for_you/Features/other/common/pageview_widgets/second_view_location/widgets/source_point.dart';

import '../../../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../../../../core/utils/resources/styles_manager.dart';

class SecondViewLocation extends StatefulWidget {
  final Function(String lat, String long, String locationName)
      onSelectSourcePlace;
  final Function(String lat, String long, String locationName)
      onSelectDestinPlace;
  final String? sourceLocationString;
  final String? destinLocationString;

  const SecondViewLocation({
    Key? key,
    required this.onSelectSourcePlace,
    required this.onSelectDestinPlace,
    this.sourceLocationString,
    this.destinLocationString,
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
        SourcePointWidget(
          onSelectPlace: widget.onSelectSourcePlace,
          sourceLocationString: widget.sourceLocationString,
        ),
        const SizedBox(height: 16),
        DestinationPointWidget(
          onSelectDestinPlace: widget.onSelectDestinPlace,
          destinLocationString: widget.destinLocationString,
        ),
      ],
    );
  }
}
