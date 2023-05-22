import 'package:equatable/equatable.dart';

class OtpEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class GenerateOtpEvent extends OtpEvents {
  final String mobileNumber;

  GenerateOtpEvent({required this.mobileNumber});
}

class ValidateOtpEvent extends OtpEvents {
  final String otp;
  final String generatedOtp;
  final String mobileNumber;

  ValidateOtpEvent({
    required this.otp,
    required this.generatedOtp,
    required this.mobileNumber,
  });
}
