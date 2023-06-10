import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:taxi_for_you/Features/other/furniture_view/bloc/furniture_event.dart';
import 'package:taxi_for_you/Features/other/furniture_view/bloc/furniture_state.dart';
import 'package:taxi_for_you/Features/other/furniture_view/models/furniture_repo.dart';

import '../../../../app/app_prefs.dart';
import '../../../../core/network/base_response.dart';

class FurnitureBloc extends Bloc<FurnitureEvent, FurnitureRequestStates> {
  final FurnitureRepo furnitureRepo;
  final AppPreferences appPreferences;

  FurnitureBloc(this.furnitureRepo, this.appPreferences)
      : super(FurnitureRequestIsNotLoading()) {
    on<SendFurnitureRequest>(_sendFurnitureRequest);
  }

  void _sendFurnitureRequest(
      SendFurnitureRequest event, Emitter<FurnitureRequestStates> emit) async {
    emit(FurnitureRequestIsLoading());

    try {
      await (furnitureRepo.sendFurnitureRequest(event.furnitureModel));

      emit(FurnitureRequestSuccessfully());
      // if (response.result != null &&
      //     response.success != null &&
      //     response.success!) {
      //   emit(FurnitureRequestSuccessfully());
      // } else {
      //   emit(FurnitureRequestFailed(baseResponse: response));
      // }
    } catch (e) {
      if (e is PlatformException) {
        if (e.message != null) {
          emit(FurnitureRequestFailed(
              baseResponse: BaseResponse(errorMessage: e.message)));
        }
      } else {
        var response = BaseResponse(errorMessage: e.toString());
        emit(FurnitureRequestFailed(baseResponse: response));
      }
    }
  }
}
