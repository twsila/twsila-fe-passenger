import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';

import '../../../../app/app_prefs.dart';
import '../../../../core/network/base_response.dart';
import '../models/car_aid_repo.dart';
import 'car_aid_event.dart';
import 'car_aid_state.dart';

class CarAidBloc extends Bloc<CarAidEvent, CarAidRequestStates> {
  final CarAidRepo goodsRepo;
  final AppPreferences appPreferences;

  CarAidBloc(this.goodsRepo, this.appPreferences)
      : super(CarAidRequestIsNotLoading()) {
    on<SendCarAidRequest>(_sendCarAidRequest);
  }

  void _sendCarAidRequest(
      SendCarAidRequest event, Emitter<CarAidRequestStates> emit) async {
    emit(CarAidRequestIsLoading());

    try {
      await (goodsRepo.sendCarAidRequest(event.carAidModel));

      emit(CarAidRequestSuccessfully());
    } catch (e) {
      if (e is PlatformException) {
        if (e.message != null) {
          emit(CarAidRequestFailed(
              baseResponse: BaseResponse(errorMessage: e.message)));
        }
      } else {
        var response = BaseResponse(errorMessage: e.toString());
        emit(CarAidRequestFailed(baseResponse: response));
      }
    }
  }
}
