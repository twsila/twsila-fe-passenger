import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:taxi_for_you/Features/registeration/bloc/registeration_event.dart';
import 'package:taxi_for_you/Features/registeration/bloc/registeration_state.dart';
import 'package:taxi_for_you/app/di.dart';
import 'package:taxi_for_you/data/model/user-model.dart';

import '../../../core/network/base_response.dart';
import '../models/registeration_repo.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationStates> {
  RegistrationRepo registrationRepo = instance<RegistrationRepo>();

  RegistrationBloc(this.registrationRepo) : super(RegistrationIsNotLoading()) {
    on<RegistrationUser>(_registerUser);
  }

  void _registerUser(
      RegistrationUser event, Emitter<RegistrationStates> emit) async {
    emit(RegistrationIsLoading());

    try {
      BaseResponse response =
          await (registrationRepo.registrationUser(event.userModel));
      if (response.result != null &&
          response.success != null &&
          response.success!) {
        dynamic results = response.result;
        UserModel userModel = UserModel.fromJson(results);

        emit(RegistrationSuccessfully(userModel));
      } else {
        emit(RegistrationFailed(baseResponse: response));
      }
    } catch (e) {
      if (e is PlatformException) {
        if (e.message != null) {
          emit(RegistrationFailed(baseResponse: e.details as BaseResponse));
        }
      }
    }
  }
}
