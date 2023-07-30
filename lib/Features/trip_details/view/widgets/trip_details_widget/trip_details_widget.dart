import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/transportation_requests/model/transportation_base_model.dart';
import 'package:taxi_for_you/Features/trip_details/view/widgets/trip_details_widget/trips_details_widget_viewmodel.dart';
import 'package:taxi_for_you/core/utils/ext/date_ext.dart';

import '../../../../../core/utils/resources/assets_manager.dart';
import '../../../../../core/utils/resources/color_manager.dart';
import '../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../core/utils/resources/styles_manager.dart';
import '../../../../common/widgets/custom_dashed_line.dart';

class TripDetailsWidget extends StatefulWidget {
  final TransportationBaseModel trip;
  const TripDetailsWidget({
    Key? key,
    required this.trip,
  }) : super(key: key);

  @override
  State<TripDetailsWidget> createState() => _TripDetailsWidgetState();
}

class _TripDetailsWidgetState extends State<TripDetailsWidget> {
  final TripsDetailsWidgetViewModel _viewModel = TripsDetailsWidgetViewModel();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(AppStrings.sendIn.tr() +
                  context.formatDateTime(
                      dateTime: DateTime.tryParse(widget.trip.creationDate!))),
            ),
            const SizedBox(width: 16),
            Image.asset(_viewModel.getIconName(widget.trip.tripType!)),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          _viewModel.getTitle(widget.trip.tripType!),
          style: getBoldStyle(
            color: ColorManager.primaryTextColor,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          AppStrings.onBudget.tr() +
              widget.trip.paymentValue.toString() +
              ' ' +
              (_viewModel.appPreferences.getCurrentCurrnecy()),
          style: getMediumStyle(
            color: ColorManager.primaryTextColor,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Image.asset(ImageAssets.pin),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                AppStrings.from.tr() +
                    (widget.trip.pickupLocation.locationName ?? ''),
                style: getMediumStyle(
                  color: ColorManager.primaryTextColor,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.all(5),
          height: 33,
          width: 3,
          child: CustomPaint(
              size: const Size(1, double.infinity),
              painter: DashedLineVerticalPainter()),
        ),
        Row(
          children: [
            Image.asset(ImageAssets.pin),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                AppStrings.to.tr() +
                    (widget.trip.destinationLocation.locationName ?? ''),
                style: getMediumStyle(
                  color: ColorManager.primaryTextColor,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
