import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';

import '../../../../app/app_prefs.dart';
import '../../../../core/network/base_response.dart';
import '../models/freezers_repo.dart';
import 'freezers_event.dart';
import 'freezers_state.dart';

class FreezersBloc extends Bloc<FreezersEvent, FreezersRequestStates> {
  final FreezersRepo goodsRepo;
  final AppPreferences appPreferences;

  FreezersBloc(this.goodsRepo, this.appPreferences)
      : super(FreezersRequestIsNotLoading()) {
    on<SendFreezersRequest>(_sendFreezersRequest);
  }

  void _sendFreezersRequest(
      SendFreezersRequest event, Emitter<FreezersRequestStates> emit) async {
    emit(FreezersRequestIsLoading());

    try {
      await (goodsRepo.sendFreezersRequest(event.freezersModel));

      emit(FreezersRequestSuccessfully());
    } catch (e) {
      if (e is PlatformException) {
        if (e.message != null) {
          emit(FreezersRequestFailed(
              baseResponse: BaseResponse(errorMessage: e.message)));
        }
      } else {
        var response = BaseResponse(errorMessage: e.toString());
        emit(FreezersRequestFailed(baseResponse: response));
      }
    }
  }
}
