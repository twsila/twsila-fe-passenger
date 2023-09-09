import 'package:equatable/equatable.dart';

import '../../../../core/network/base_response.dart';

class HomeStates extends Equatable {
  @override
  List<Object> get props => [];
}

class LogoutIsNotLoading extends HomeStates {}

class LogoutIsLoading extends HomeStates {}

class LogoutSuccessfully extends HomeStates {}

class LogoutFailed extends HomeStates {
  final BaseResponse baseResponse;

  LogoutFailed({required this.baseResponse});
  @override
  List<Object> get props => [baseResponse];
}
