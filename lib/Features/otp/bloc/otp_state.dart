import 'package:equatable/equatable.dart';

import '../../../core/network/base_response.dart';

//Generate Otp States
class OtpStates extends Equatable {
  @override
  List<Object> get props => [];
}

class GenerateOtpIsNotLoading extends OtpStates {}

class GenerateOtpIsLoading extends OtpStates {}

class GenerateOtpSuccessfully extends OtpStates {
  final String otp;

  GenerateOtpSuccessfully({required this.otp});
  @override
  List<Object> get props => [otp];
}

class GenerateOtpFailed extends OtpStates {
  final BaseResponse? baseResponse;

  GenerateOtpFailed({this.baseResponse});
}

//Validate Otp States
class ValidateOtpStates extends Equatable {
  @override
  List<Object> get props => [];
}

class ValidateOtpIsNotLoading extends OtpStates {}

class ValidateOtpIsLoading extends OtpStates {}

class ValidateOtpSuccessfully extends OtpStates {}

class ValidateOtpFailed extends OtpStates {
  final BaseResponse? baseResponse;

  ValidateOtpFailed({this.baseResponse});
}
