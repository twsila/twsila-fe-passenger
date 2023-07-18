import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/transportation_requests/model/transportation_base_model.dart';
import 'package:taxi_for_you/Features/trip_details/view/widgets/trip_details_widget/trips_details_widget_viewmodel.dart';
import 'package:taxi_for_you/core/utils/ext/date_ext.dart';

import '../../../../../core/utils/resources/color_manager.dart';
import '../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../core/utils/resources/styles_manager.dart';

class MyTripDetails extends StatefulWidget {
  final TransportationBaseModel trip;
  const MyTripDetails({Key? key, required this.trip}) : super(key: key);

  @override
  State<MyTripDetails> createState() => _MyTripDetailsState();
}

class _MyTripDetailsState extends State<MyTripDetails> {
  final TripsDetailsWidgetViewModel _viewModel = TripsDetailsWidgetViewModel();
  @override
  void initState() {
    _viewModel.setTripType(widget.trip.tripType!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.sendIn.tr() +
            context.formatDateTime(
                dateTime: DateTime.tryParse(widget.trip.creationDate!))),
        Text(
          _viewModel.getTitle(),
          style: getBoldStyle(
            color: ColorManager.primaryTextColor,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          AppStrings.from.tr() +
              ': ' +
              (widget.trip.pickupLocation.locationName ?? ''),
          style: getBoldStyle(
            color: ColorManager.primaryTextColor,
            fontSize: 14,
          ),
        ),
        Text(
          AppStrings.to.tr() +
              ': ' +
              (widget.trip.destinationLocation.locationName ?? ''),
          style: getBoldStyle(
            color: ColorManager.primaryTextColor,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
