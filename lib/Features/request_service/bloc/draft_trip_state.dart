import 'package:equatable/equatable.dart';

import '../../../core/network/base_response.dart';
import '../../trip_details/model/trip_details_model.dart';

class DraftTripStates extends Equatable {
  @override
  List<Object> get props => [];
}

class DraftTripIsNotLoading extends DraftTripStates {}

class DraftTripIsLoading extends DraftTripStates {}

class DraftTripSuccessfully extends DraftTripStates {
  final TripDetailsModel transportationBaseModel;

  DraftTripSuccessfully({
    required this.transportationBaseModel,
  });
}

class DraftTripFailed extends DraftTripStates {
  final BaseResponse baseResponse;

  DraftTripFailed({required this.baseResponse});
  @override
  List<Object> get props => [baseResponse];
}
