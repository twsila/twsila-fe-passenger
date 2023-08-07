import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/transportation_requests/model/transportation_base_model.dart';
import 'package:taxi_for_you/Features/trip_details/view/widgets/trip_status_ui/widgets/trip_active.dart';
import 'package:taxi_for_you/Features/trip_details/view/widgets/trip_status_ui/widgets/trip_cancelled.dart';
import 'package:taxi_for_you/Features/trip_details/view/widgets/trip_status_ui/widgets/trip_completed.dart';
import 'package:taxi_for_you/Features/trip_details/view/widgets/trip_status_ui/widgets/trip_submitted.dart';
import 'package:taxi_for_you/app/constants.dart';

class TripDetailsStatusWidget extends StatelessWidget {
  final TransportationBaseModel transportationBaseModel;
  const TripDetailsStatusWidget({
    Key? key,
    required this.transportationBaseModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (transportationBaseModel.tripStatus == TripStatusConstants.cancelled) {
      return TripCancelled(
        transportationBaseModel: transportationBaseModel,
      );
    } else if (transportationBaseModel.tripStatus ==
        TripStatusConstants.completed) {
      return TripCompleted(
        transportationBaseModel: transportationBaseModel,
      );
    } else if (transportationBaseModel.tripStatus ==
            TripStatusConstants.submitted ||
        transportationBaseModel.tripStatus == TripStatusConstants.evaluation ||
        transportationBaseModel.tripStatus == TripStatusConstants.payment) {
      return TripSubmitted(
        transportationBaseModel: transportationBaseModel,
      );
    }
    return TripActive(
      transportationBaseModel: transportationBaseModel,
    );
  }
}
