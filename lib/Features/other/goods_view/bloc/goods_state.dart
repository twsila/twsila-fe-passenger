import 'package:equatable/equatable.dart';

import '../../../../core/network/base_response.dart';

class GoodsRequestStates extends Equatable {
  @override
  List<Object> get props => [];
}

class GoodsRequestIsNotLoading extends GoodsRequestStates {}

class GoodsRequestIsLoading extends GoodsRequestStates {}

class GoodsRequestSuccessfully extends GoodsRequestStates {}

class GoodsRequestFailed extends GoodsRequestStates {
  final BaseResponse baseResponse;

  GoodsRequestFailed({required this.baseResponse});
  @override
  List<Object> get props => [baseResponse];
}
