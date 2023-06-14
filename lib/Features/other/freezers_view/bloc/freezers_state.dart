import 'package:equatable/equatable.dart';

import '../../../../core/network/base_response.dart';

class FreezersRequestStates extends Equatable {
  @override
  List<Object> get props => [];
}

class FreezersRequestIsNotLoading extends FreezersRequestStates {}

class FreezersRequestIsLoading extends FreezersRequestStates {}

class FreezersRequestSuccessfully extends FreezersRequestStates {}

class FreezersRequestFailed extends FreezersRequestStates {
  final BaseResponse baseResponse;

  FreezersRequestFailed({required this.baseResponse});
  @override
  List<Object> get props => [baseResponse];
}
