import 'package:equatable/equatable.dart';
import 'package:taxi_for_you/Features/trip_details/model/offer_model.dart';
import 'package:taxi_for_you/Features/trip_details/model/trip_details_model.dart';

import '../../../../core/network/base_response.dart';

class TripDetailsStates extends Equatable {
  @override
  List<Object> get props => [];
}

class TripDetailsIsNotLoading extends TripDetailsStates {}

class TripDetailsIsLoading extends TripDetailsStates {}

class AcceptOfferIsLoading extends TripDetailsStates {}

class RatingTripIsLoading extends TripDetailsStates {}

class TripDetailsSuccessfully extends TripDetailsStates {
  final TripDetailsModel tripDetailsModel;

  TripDetailsSuccessfully({
    required this.tripDetailsModel,
  });
}

class TripDetailsFailed extends TripDetailsStates {
  final BaseResponse baseResponse;

  TripDetailsFailed({required this.baseResponse});
  @override
  List<Object> get props => [baseResponse];
}

class AcceptOfferSuccessfully extends TripDetailsStates {
  final OfferModel acceptedOffer;
  AcceptOfferSuccessfully({required this.acceptedOffer});
}

class RatingTripSuccessfully extends TripDetailsStates {}

class AcceptOfferFailed extends TripDetailsStates {
  final BaseResponse baseResponse;

  AcceptOfferFailed({required this.baseResponse});
  @override
  List<Object> get props => [baseResponse];
}

class CancelTripSuccessfully extends TripDetailsStates {}

class CancelTripFailed extends TripDetailsStates {
  final BaseResponse baseResponse;

  CancelTripFailed({required this.baseResponse});
  @override
  List<Object> get props => [baseResponse];
}

class RatingTripFailed extends TripDetailsStates {
  final BaseResponse baseResponse;

  RatingTripFailed({required this.baseResponse});
  @override
  List<Object> get props => [baseResponse];
}
