import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:taxi_for_you/Features/transportation_requests/bloc/transportation_event.dart';
import 'package:taxi_for_you/Features/transportation_requests/bloc/transportation_state.dart';

import '../../../../app/app_prefs.dart';
import '../../../../core/network/base_response.dart';
import '../model/transportation_repo.dart';

class TransportationBloc
    extends Bloc<TransportationEvent, TransportationRequestStates> {
  final TransportationRepo goodsRepo;
  final AppPreferences appPreferences;

  TransportationBloc(this.goodsRepo, this.appPreferences)
      : super(TransportationRequestIsNotLoading()) {
    on<SendTransportationRequest>(_sendTransportationRequest);
  }

  void _sendTransportationRequest(SendTransportationRequest event,
      Emitter<TransportationRequestStates> emit) async {
    emit(TransportationRequestIsLoading());

    try {
      await (goodsRepo.sendTransportationRequest(
        event.endPoint,
        event.files,
        event.body,
      ));

      emit(TransportationRequestSuccessfully());
    } catch (e) {
      if (e is PlatformException) {
        if (e.message != null) {
          emit(TransportationRequestFailed(
              baseResponse: BaseResponse(errorMessage: e.message)));
        }
      } else {
        var response = BaseResponse(errorMessage: e.toString());
        emit(TransportationRequestFailed(baseResponse: response));
      }
    }
  }
}
