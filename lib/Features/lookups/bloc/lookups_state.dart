import 'package:equatable/equatable.dart';

import '../../../../core/network/base_response.dart';

class LookupsStates extends Equatable {
  @override
  List<Object> get props => [];
}

class LookupsIsNotLoading extends LookupsStates {}

class LookupsIsLoading extends LookupsStates {}

class LookupsSuccessfully extends LookupsStates {}

class LookupsFailed extends LookupsStates {
  final BaseResponse baseResponse;

  LookupsFailed({required this.baseResponse});
  @override
  List<Object> get props => [baseResponse];
}
