import 'package:equatable/equatable.dart';

import '../../../../core/network/base_response.dart';
import '../../trip_details/model/trip_details_model.dart';
import '../model/transportation_base_model.dart';

class TransportationRequestStates extends Equatable {
  @override
  List<Object> get props => [];
}

class TransportationRequestIsNotLoading extends TransportationRequestStates {}

class TransportationRequestIsLoading extends TransportationRequestStates {}

class TransportationRequestSuccessfully extends TransportationRequestStates {
  final int tripId;
  final TransportationBaseModel transportationBaseModel;
  final Map<String, dynamic> body;
  final String endPoint;

  TransportationRequestSuccessfully({
    required this.tripId,
    required this.transportationBaseModel,
    required this.body,
    required this.endPoint,
  });
}

class TransportationRequestFailed extends TransportationRequestStates {
  final BaseResponse baseResponse;

  TransportationRequestFailed({required this.baseResponse});
  @override
  List<Object> get props => [baseResponse];
}
