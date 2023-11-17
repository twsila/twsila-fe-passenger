import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:taxi_for_you/Features/otp/bloc/otp_event.dart';
import 'package:taxi_for_you/Features/otp/bloc/otp_state.dart';
import 'package:taxi_for_you/Features/otp/model/otp_repo.dart';
import 'package:taxi_for_you/app/di.dart';

import '../../../core/network/base_response.dart';

class OtpBloc extends Bloc<OtpEvents, OtpStates> {
  OtpRepo otpRepo = instance<OtpRepo>();

  OtpBloc(this.otpRepo) : super(GenerateOtpIsNotLoading()) {
    on<GenerateOtpEvent>(_generateOtp);
    on<ValidateOtpEvent>(_validateOtp);
  }

  void _generateOtp(GenerateOtpEvent event, Emitter<OtpStates> emit) async {
    emit(GenerateOtpIsLoading());

    try {
      BaseResponse response =
          await (otpRepo.generateOtp(event.mobileNumber, event.appSignature));
      if (response.result != null &&
          response.success != null &&
          response.success!) {
        dynamic results = response.result;
        String otp = results['otp'];

        emit(GenerateOtpSuccessfully(otp: otp));
      } else {
        emit(GenerateOtpFailed(baseResponse: response));
      }
    } catch (e) {
      if (e is PlatformException) {
        if (e.message != null && e.details != null) {
          emit(GenerateOtpFailed(baseResponse: e.details as BaseResponse));
        }
        emit(GenerateOtpFailed());
      }
      emit(GenerateOtpFailed());
    }
  }

  void _validateOtp(ValidateOtpEvent event, Emitter<OtpStates> emit) async {
    emit(ValidateOtpIsLoading());

    try {
      BaseResponse response = await (otpRepo.validateOtp(
          event.otp, event.generatedOtp, event.mobileNumber));
      if (response.result != null &&
          response.success != null &&
          response.success!) {
        emit(ValidateOtpSuccessfully());
      } else {
        emit(ValidateOtpFailed(baseResponse: response));
      }
    } catch (e) {
      if (e is PlatformException) {
        if (e.message != null && e.details != null) {
          emit(ValidateOtpFailed(baseResponse: e.details as BaseResponse));
        }
        emit(ValidateOtpFailed());
      }
      emit(ValidateOtpFailed());
    }
  }
}
