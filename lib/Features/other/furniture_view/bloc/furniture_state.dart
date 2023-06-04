import 'package:equatable/equatable.dart';

import '../../../../core/network/base_response.dart';

class FurnitureRequestStates extends Equatable {
  @override
  List<Object> get props => [];
}

class FurnitureRequestIsNotLoading extends FurnitureRequestStates {}

class FurnitureRequestIsLoading extends FurnitureRequestStates {}

class FurnitureRequestSuccessfully extends FurnitureRequestStates {}

class FurnitureRequestFailed extends FurnitureRequestStates {
  final BaseResponse baseResponse;

  FurnitureRequestFailed({required this.baseResponse});
  @override
  List<Object> get props => [baseResponse];
}
