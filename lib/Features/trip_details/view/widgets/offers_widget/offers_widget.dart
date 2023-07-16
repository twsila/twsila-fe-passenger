import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/trip_details/model/offer_model.dart';
import 'package:taxi_for_you/Features/trip_details/view/widgets/offers_widget/offers_status/trip_accepted_offer.dart';
import 'package:taxi_for_you/Features/trip_details/view/widgets/offers_widget/offers_status/trip_all_offers.dart';
import 'package:taxi_for_you/Features/trip_details/view/widgets/offers_widget/offers_status/trip_no_offers.dart';

class OffersWidget extends StatefulWidget {
  final AcceptedOffer? acceptedOffer;
  final List<OfferModel>? offers;
  const OffersWidget({
    Key? key,
    required this.acceptedOffer,
    required this.offers,
  }) : super(key: key);

  @override
  State<OffersWidget> createState() => _OffersWidgetState();
}

class _OffersWidgetState extends State<OffersWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.acceptedOffer != null
        ? TripAccepterdOffer(offer: widget.acceptedOffer!.offer)
        : widget.offers != null
            ? TripAllOffer(offers: widget.offers!)
            : const TripNoOffers();
  }
}
