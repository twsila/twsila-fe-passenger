import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/transportation_requests/model/transportation_base_model.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/constants.dart';
import 'package:taxi_for_you/app/di.dart';
import 'package:taxi_for_you/core/utils/ext/date_ext.dart';
import 'package:taxi_for_you/core/utils/helpers/trip_helper.dart';

import '../../../../../core/utils/resources/assets_manager.dart';
import '../../../../../core/utils/resources/color_manager.dart';
import '../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../core/utils/resources/styles_manager.dart';
import '../../../../common/widgets/custom_dashed_line.dart';

class TripDetailsWidget extends StatefulWidget {
  final TransportationBaseModel trip;
  const TripDetailsWidget({
    Key? key,
    required this.trip,
  }) : super(key: key);

  @override
  State<TripDetailsWidget> createState() => _TripDetailsWidgetState();
}

class _TripDetailsWidgetState extends State<TripDetailsWidget> {
  final AppPreferences appPreferences = instance();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(AppStrings.sendIn.tr() +
                  widget.trip.creationDate!.getTimeStampFromDate()),
            ),
            const SizedBox(width: 16),
            Image.asset(TripHelper.getIconName(widget.trip.tripType!)),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          TripHelper.getTripTitle(widget.trip.tripType!),
          style: getBoldStyle(
            color: ColorManager.primaryTextColor,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 4),
        (widget.trip.tripStatus == TripStatusConstants.submitted ||
                widget.trip.tripStatus == TripStatusConstants.evaluation ||
                widget.trip.tripStatus == TripStatusConstants.payment)
            ? widget.trip.acceptedOffer != null
                ? Text(
                    AppStrings.onBudget.tr() +
                        (widget.trip.acceptedOffer!.offer.driverOffer != 0.0
                            ? widget.trip.acceptedOffer!.offer.driverOffer
                                .toString()
                            : widget.trip.paymentValue.toString()) +
                        ' ' +
                        (appPreferences.getCurrentCurrnecy()),
                    style: getMediumStyle(
                      color: ColorManager.primaryTextColor,
                      fontSize: 18,
                    ),
                  )
                : widget.trip.paymentValue != 0.0
                    ? Text(
                        AppStrings.onBudget.tr() +
                            widget.trip.paymentValue!.toInt().toString() +
                            ' ' +
                            (appPreferences.getCurrentCurrnecy()),
                        style: getMediumStyle(
                          color: ColorManager.primaryTextColor,
                          fontSize: 18,
                        ),
                      )
                    : const SizedBox()
            : widget.trip.tripStatus == TripStatusConstants.cancelled
                ? widget.trip.cancelledBy ==
                        TripStatusConstants.cancelledByPassenger
                    ? const SizedBox()
                    : Row(
                        children: [
                          Image.asset(ImageAssets.tripMarked),
                          const SizedBox(width: 16),
                          Text(
                            AppStrings.tripRefunded.tr() +
                                widget.trip.paymentValue.toString() +
                                ' ' +
                                (appPreferences.getCurrentCurrnecy()) +
                                ' ' +
                                AppStrings.toYourWallet.tr(),
                            style: getMediumStyle(
                              color: ColorManager.green,
                              fontSize: 18,
                            ),
                          )
                        ],
                      )
                : Row(
                    children: [
                      Image.asset(ImageAssets.tripMarked),
                      const SizedBox(width: 16),
                      Text(
                        AppStrings.tripPaidConfirmed.tr() +
                            (widget.trip.acceptedOffer!.offer.driverOffer != 0.0
                                ? widget.trip.acceptedOffer!.offer.driverOffer
                                    .toString()
                                : widget.trip.paymentValue.toString()) +
                            ' ' +
                            (appPreferences.getCurrentCurrnecy()),
                        style: getMediumStyle(
                          color: ColorManager.green,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
        const SizedBox(height: 16),
        if (widget.trip.pickupLocation.locationName != "")
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(ImageAssets.pin),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      AppStrings.from.tr() +
                          (widget.trip.pickupLocation.locationName ?? ''),
                      style: getMediumStyle(
                        color: ColorManager.primaryTextColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.all(5),
                height: 33,
                width: 3,
                child: CustomPaint(
                    size: const Size(1, double.infinity),
                    painter: DashedLineVerticalPainter()),
              ),
            ],
          ),
        Row(
          children: [
            Image.asset(ImageAssets.pin),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                AppStrings.to.tr() +
                    (widget.trip.destinationLocation.locationName ?? ''),
                style: getMediumStyle(
                  color: ColorManager.primaryTextColor,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
