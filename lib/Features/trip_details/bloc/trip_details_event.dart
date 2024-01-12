import 'package:equatable/equatable.dart';

class TripDetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetTripDetailsRequest extends TripDetailsEvent {
  final int tripId;

  GetTripDetailsRequest({
    required this.tripId,
  });
}

class AcceptOfferRequest extends TripDetailsEvent {
  final int offerId;

  AcceptOfferRequest({
    required this.offerId,
  });
}

class CancelTripRequest extends TripDetailsEvent {
  final int tripId;

  CancelTripRequest({
    required this.tripId,
  });
}

class RateTrip extends TripDetailsEvent {
  final int tripId;
  final int driverRating;
  final int tripRating;

  RateTrip({
    required this.tripId,
    required this.driverRating,
    required this.tripRating,
  });
}
