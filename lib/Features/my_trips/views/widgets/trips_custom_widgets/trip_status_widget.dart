import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/transportation_requests/model/transportation_base_model.dart';
import 'package:taxi_for_you/app/constants.dart';
import 'package:taxi_for_you/core/utils/helpers/date_helper.dart';
import 'package:taxi_for_you/core/utils/helpers/trip_helper.dart';
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
  @override
  Widget build(BuildContext context) {
    return Text(
      TripHelper.getTripText(widget.trip),
      style: getBoldStyle(
        color: TripHelper.getTextColor(widget.trip),
        fontSize: 16,
      ),
    );
  }
}
