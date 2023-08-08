import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/trip_details/view/widgets/offers_buttons/track_trip_button.dart';
import 'package:taxi_for_you/app/constants.dart';
import 'package:taxi_for_you/core/utils/helpers/trip_helper.dart';

import '../../../../../../core/utils/resources/assets_manager.dart';
import '../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../core/utils/resources/styles_manager.dart';
import '../../../../../transportation_requests/model/transportation_base_model.dart';
import '../../more_details_widget/more_details_widget.dart';
import '../../offers_buttons/cancel_trip_button.dart';
import '../../offers_buttons/need_help_button.dart';
import '../../offers_widget/offers_widget.dart';
import '../../trip_details_widget/trip_details_widget.dart';

class TripActive extends StatelessWidget {
  final TransportationBaseModel transportationBaseModel;
  const TripActive({Key? key, required this.transportationBaseModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            color: ColorManager.primaryTextColor,
            child: Row(
              children: [
                Image.asset(ImageAssets.tripRoad),
                const SizedBox(width: 16),
                Text(
                  TripHelper.getTripText(transportationBaseModel),
                  style: getMediumStyle(color: Colors.white, fontSize: 16),
                )
              ],
            ),
          ),
          TripDetailsWidget(trip: transportationBaseModel),
          TrackTripButton(tripId: transportationBaseModel.tripId!),
          const SizedBox(height: 16),
          MoreDetailsWidget(
            transportationBaseModel: transportationBaseModel,
          ),
          OffersWidget(
            transportationBaseModel: transportationBaseModel,
          ),
          NeedHelpButton(tripId: transportationBaseModel.tripId!),
          if (transportationBaseModel.tripStatus ==
              TripStatusConstants.waitForTakeOff)
            CancelTripButton(tripId: transportationBaseModel.tripId!),
        ],
      ),
    );
  }
}
