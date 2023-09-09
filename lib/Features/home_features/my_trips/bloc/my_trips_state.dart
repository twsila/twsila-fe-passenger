import 'package:equatable/equatable.dart';
import 'package:taxi_for_you/Features/trip_details/model/trip_details_model.dart';

import '../../../../../core/network/base_response.dart';

class MyTripsStates extends Equatable {
  @override
  List<Object> get props => [];
}

class MyTripsIsNotLoading extends MyTripsStates {}

class MyTripsIsLoading extends MyTripsStates {}

class MyTripsSuccessfully extends MyTripsStates {
  final List<TripDetailsModel> trips;

  MyTripsSuccessfully({
    required this.trips,
  });
}

class MyTripsFailed extends MyTripsStates {
  final BaseResponse baseResponse;

  MyTripsFailed({required this.baseResponse});
  @override
  List<Object> get props => [baseResponse];
}
