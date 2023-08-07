import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/trip_details/view/widgets/offers_buttons/need_help_button.dart';
import 'package:taxi_for_you/core/utils/helpers/trip_helper.dart';
import '../../../../../../core/utils/resources/styles_manager.dart';
import '../../../../../transportation_requests/model/transportation_base_model.dart';
import '../../trip_details_widget/trip_details_widget.dart';

class TripCancelled extends StatelessWidget {
  final TransportationBaseModel transportationBaseModel;
  const TripCancelled({Key? key, required this.transportationBaseModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          color: Colors.red,
          child: Row(
            children: [
              const Icon(
                Icons.cancel,
                color: Colors.white,
              ),
              const SizedBox(width: 16),
              Text(
                TripHelper.getTripText(transportationBaseModel),
                style: getMediumStyle(color: Colors.white, fontSize: 16),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            children: [
              TripDetailsWidget(trip: transportationBaseModel),
              const SizedBox(height: 16),
              const Divider(color: Colors.grey),
              NeedHelpButton(tripId: transportationBaseModel.tripId!),
            ],
          ),
        ),
      ],
    );
  }
}
