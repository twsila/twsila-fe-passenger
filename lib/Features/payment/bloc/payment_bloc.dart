import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:taxi_for_you/Features/payment/bloc/payment_event.dart';
import 'package:taxi_for_you/Features/payment/bloc/payment_state.dart';
import 'package:taxi_for_you/Features/payment/model/payment_repo.dart';
import 'package:taxi_for_you/app/di.dart';

import '../../../core/network/base_response.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentStates> {
  PaymentRepo paymentRepo = instance<PaymentRepo>();

  PaymentBloc(this.paymentRepo) : super(PaymentIsNotLoading()) {
    on<SendPaymentRequest>(_sendPaymentRequest);
  }

  void _sendPaymentRequest(
      SendPaymentRequest event, Emitter<PaymentStates> emit) async {
    emit(PaymentIsLoading());

    try {
      BaseResponse response = await (paymentRepo.paymentRequest(event.tripId));
      if (response.success != null && response.success!) {
        emit(PaymentSuccessfully());
      } else {
        emit(PaymentFailed(baseResponse: response));
      }
    } catch (e) {
      if (e is PlatformException) {
        if (e.message != null && e.details != null) {
          emit(PaymentFailed(baseResponse: e.details as BaseResponse));
        }
      }
    }
  }
}
