import 'package:equatable/equatable.dart';

import '../../../../core/network/base_response.dart';

class CarAidRequestStates extends Equatable {
  @override
  List<Object> get props => [];
}

class CarAidRequestIsNotLoading extends CarAidRequestStates {}

class CarAidRequestIsLoading extends CarAidRequestStates {}

class CarAidRequestSuccessfully extends CarAidRequestStates {}

class CarAidRequestFailed extends CarAidRequestStates {
  final BaseResponse baseResponse;

  CarAidRequestFailed({required this.baseResponse});
  @override
  List<Object> get props => [baseResponse];
}
