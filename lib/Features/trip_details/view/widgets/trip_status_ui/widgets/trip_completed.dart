import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/trip_details/view/widgets/offers_buttons/need_help_button.dart';
import 'package:taxi_for_you/Features/trip_details/view/widgets/trip_status_ui/widgets/trip_rating.dart';
import 'package:taxi_for_you/core/utils/resources/assets_manager.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';
import 'package:taxi_for_you/core/utils/resources/styles_manager.dart';

import '../../../../../transportation_requests/model/transportation_base_model.dart';
import '../../offers_widget/offers_widget.dart';
import '../../trip_details_widget/trip_details_widget.dart';

class TripCompleted extends StatelessWidget {
  final TransportationBaseModel transportationBaseModel;
  const TripCompleted({Key? key, required this.transportationBaseModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: ColorManager.green,
          child: Row(
            children: [
              Image.asset(ImageAssets.tripFinished),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  AppStrings.tripStatusCOMLETED.tr(),
                  style: getMediumStyle(color: Colors.white, fontSize: 16),
                ),
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
              transportationBaseModel.passengerRating == null ||
                      transportationBaseModel.passengerRating == -1
                  ? TripRating(tripDetails: transportationBaseModel)
                  : const SizedBox(),
              NeedHelpButton(tripId: transportationBaseModel.tripId!)
            ],
          ),
        ),
      ],
    );
  }
}
