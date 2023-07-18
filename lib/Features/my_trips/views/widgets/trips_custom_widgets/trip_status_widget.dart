import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/transportation_requests/model/transportation_base_model.dart';
import 'package:taxi_for_you/core/utils/ext/date_ext.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';
import 'package:taxi_for_you/core/utils/resources/styles_manager.dart';

class TripStatus extends StatefulWidget {
  final TransportationBaseModel trip;
  const TripStatus({Key? key, required this.trip}) : super(key: key);

  @override
  State<TripStatus> createState() => _TripStatusState();
}

class _TripStatusState extends State<TripStatus> {
  String text = AppStrings.waitingOffers.tr();
  Color color = ColorManager.primary;

  @override
  void initState() {
    checkStatus();
    super.initState();
  }

  checkStatus() {
    String? status = widget.trip.tripStatus;
    if (status != null) {
      if (status == 'CANCELLED') {
        text = AppStrings.passengerCancelled.tr();
        color = ColorManager.error;
      } else if (status == 'COMPLETED') {
        text = AppStrings.tripFinished.tr();
        color = ColorManager.green;
      } else if (widget.trip.acceptedOffer != null &&
          widget.trip.acceptedOffer!.offer.acceptanceStatus == 'ACCEPTED') {
        if (status == 'DRAFT') {
          text = AppStrings.tripStartIn.tr() +
              context.formatDateTime(
                dateTime: DateTime.tryParse(
                  widget.trip.date ?? widget.trip.creationDate!,
                ),
              );
        } else if (status == 'TAKEOFF') {}
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getBoldStyle(color: color, fontSize: 16),
    );
  }
}
