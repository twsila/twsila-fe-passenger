import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/transportation_requests/model/transportation_base_model.dart';
import 'package:taxi_for_you/Features/trip_details/view/widgets/offers_widget/offers_status/trip_accepted_offer.dart';
import 'package:taxi_for_you/Features/trip_details/view/widgets/offers_widget/offers_status/trip_all_offers.dart';
import 'package:taxi_for_you/Features/trip_details/view/widgets/offers_widget/offers_status/trip_no_offers.dart';

class OffersWidget extends StatefulWidget {
  final TransportationBaseModel transportationBaseModel;
  const OffersWidget({
    Key? key,
    required this.transportationBaseModel,
  }) : super(key: key);

  @override
  State<OffersWidget> createState() => _OffersWidgetState();
}

class _OffersWidgetState extends State<OffersWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.transportationBaseModel.acceptedOffer != null
        ? TripAccepterdOffer(
            transportationBaseModel: widget.transportationBaseModel)
        : widget.transportationBaseModel.offers != null
            ? TripAllOffer(
                transportationBaseModel: widget.transportationBaseModel,
              )
            : const TripNoOffers();
  }
}
