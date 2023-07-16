import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/trip_details/view/widgets/offers_widget/offers_status/single_offer_widget.dart';

import '../../../../model/offer_model.dart';

class TripAccepterdOffer extends StatefulWidget {
  final OfferModel offer;
  const TripAccepterdOffer({
    Key? key,
    required this.offer,
  }) : super(key: key);

  @override
  State<TripAccepterdOffer> createState() => _TripAccepterdOfferState();
}

class _TripAccepterdOfferState extends State<TripAccepterdOffer> {
  @override
  Widget build(BuildContext context) {
    return SingleOfferWidget(offer: widget.offer);
  }
}
