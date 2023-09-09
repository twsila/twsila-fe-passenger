import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/home_features/my_trips/views/my_trips_viewmodel.dart';
import 'package:taxi_for_you/core/utils/ext/screen_size_ext.dart';

import '../../../../../core/utils/resources/color_manager.dart';
import '../../../../../core/utils/resources/strings_manager.dart';

class TripsToggleWidget extends StatefulWidget {
  final MyTripsViewModel viewModel;
  final Function(int) onPressed;
  const TripsToggleWidget({
    Key? key,
    required this.viewModel,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<TripsToggleWidget> createState() => _TripsToggleWidgetState();
}

class _TripsToggleWidgetState extends State<TripsToggleWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ToggleButtons(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            width: context.getWidth() / 2.5,
            child: Center(
              child: Text(
                AppStrings.upcoming.tr(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            width: context.getWidth() / 2.5,
            child: Center(
              child: Text(
                AppStrings.past.tr(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
        borderColor: ColorManager.lightPrimary,
        isSelected: widget.viewModel.selections,
        selectedColor: ColorManager.white,
        fillColor: ColorManager.primaryTextColor,
        onPressed: widget.onPressed,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
    );
  }
}
