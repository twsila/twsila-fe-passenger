import 'package:equatable/equatable.dart';

import '../../../../core/network/base_response.dart';

class PaymentStates extends Equatable {
  @override
  List<Object> get props => [];
}

class PaymentIsNotLoading extends PaymentStates {}

class PaymentIsLoading extends PaymentStates {}

class PaymentSuccessfully extends PaymentStates {}

class PaymentFailed extends PaymentStates {
  final BaseResponse baseResponse;

  PaymentFailed({required this.baseResponse});
  @override
  List<Object> get props => [baseResponse];
}
