import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/home_features/my_trips/views/widgets/trips_custom_widgets/fastest_time_widget.dart';
import 'package:taxi_for_you/Features/home_features/my_trips/views/widgets/trips_custom_widgets/my_trip_details.dart';
import 'package:taxi_for_you/Features/home_features/my_trips/views/widgets/trips_custom_widgets/scheduled_time_widget.dart';
import 'package:taxi_for_you/Features/home_features/my_trips/views/widgets/trips_custom_widgets/trip_number.dart';
import 'package:taxi_for_you/Features/home_features/my_trips/views/widgets/trips_custom_widgets/trip_status_widget.dart';
import 'package:taxi_for_you/Features/transportation_requests/model/transportation_base_model.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';

class MyTripsWidget extends StatefulWidget {
  final TransportationBaseModel tripModel;
  const MyTripsWidget({
    Key? key,
    required this.tripModel,
  }) : super(key: key);

  @override
  State<MyTripsWidget> createState() => _MyTripsWidgetState();
}

class _MyTripsWidgetState extends State<MyTripsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            spreadRadius: 1,
            offset: Offset(0.0, 1.0),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              widget.tripModel.launchDate == null
                  ? const FastestTimeWidget()
                  : const ScheduledTimeWidget(),
              const SizedBox(width: 8),
              if (widget.tripModel.tripNumber != null)
                Expanded(child: TripNumberWidget(tripNumber: widget.tripModel.tripNumber!))
            ],
          ),
          const SizedBox(height: 8),
          MyTripDetails(trip: widget.tripModel),
          Divider(color: ColorManager.grey),
          TripStatus(trip: widget.tripModel)
        ],
      ),
    );
  }
}
