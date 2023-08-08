import 'package:flutter/material.dart';

import '../../../../../transportation_requests/model/transportation_base_model.dart';
import '../../more_details_widget/more_details_widget.dart';
import '../../offers_buttons/cancel_trip_button.dart';
import '../../offers_buttons/need_help_button.dart';
import '../../offers_widget/offers_widget.dart';
import '../../trip_details_widget/trip_details_widget.dart';

class TripSubmitted extends StatelessWidget {
  final TransportationBaseModel transportationBaseModel;
  const TripSubmitted({
    Key? key,
    required this.transportationBaseModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          TripDetailsWidget(trip: transportationBaseModel),
          const SizedBox(height: 16),
          MoreDetailsWidget(
            transportationBaseModel: transportationBaseModel,
          ),
          OffersWidget(
            transportationBaseModel: transportationBaseModel,
          ),
          NeedHelpButton(tripId: transportationBaseModel.tripId!),
          CancelTripButton(tripId: transportationBaseModel.tripId!),
        ],
      ),
    );
  }
}
