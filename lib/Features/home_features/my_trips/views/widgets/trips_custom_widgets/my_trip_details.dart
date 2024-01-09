import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/transportation_requests/model/transportation_base_model.dart';
import 'package:taxi_for_you/core/utils/ext/date_ext.dart';
import 'package:taxi_for_you/core/utils/helpers/trip_helper.dart';

import '../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../../core/utils/resources/styles_manager.dart';

class MyTripDetails extends StatefulWidget {
  final TransportationBaseModel trip;
  const MyTripDetails({Key? key, required this.trip}) : super(key: key);

  @override
  State<MyTripDetails> createState() => _MyTripDetailsState();
}

class _MyTripDetailsState extends State<MyTripDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.sendIn.tr() +
            widget.trip.creationDate!.getTimeStampFromDate()),
        Text(
          TripHelper.getTripTitle(widget.trip.tripType!),
          style: getBoldStyle(
            color: ColorManager.primaryTextColor,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 8),
        if (widget.trip.pickupLocation.locationName != null &&
            widget.trip.pickupLocation.locationName != '')
          Text(
            AppStrings.from.tr() +
                ': ' +
                (widget.trip.pickupLocation.locationName ?? ''),
            style: getBoldStyle(
              color: ColorManager.primaryTextColor,
              fontSize: 14,
            ),
          ),
        if (widget.trip.destinationLocation.locationName != null &&
            widget.trip.destinationLocation.locationName != '')
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
