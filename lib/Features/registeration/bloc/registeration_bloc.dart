import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:taxi_for_you/Features/registeration/bloc/registeration_event.dart';
import 'package:taxi_for_you/Features/registeration/bloc/registeration_state.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/di.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';
import 'package:taxi_for_you/data/model/user-model.dart';

import '../../../core/network/base_response.dart';
import '../models/registeration_repo.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationStates> {
  RegistrationRepo registrationRepo = instance<RegistrationRepo>();
  final AppPreferences appPreferences;

  RegistrationBloc(this.registrationRepo, this.appPreferences)
      : super(RegistrationIsNotLoading()) {
    on<RegistrationUser>(_registerUser);
    on<EditUser>(_editUser);
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

  void _editUser(EditUser event, Emitter<RegistrationStates> emit) async {
    emit(RegistrationIsLoading());

    try {
      BaseResponse response =
          await (registrationRepo.editUser(event.userModel));
      if (response.result != null &&
          response.success != null &&
          response.success!) {
        dynamic results = response.result;
        UserModel userModel = UserModel.fromJson(results);
        await appPreferences.setUserLoggedIn(userModel);
        emit(EditUserSuccessfully(userModel));
      } else {
        emit(EditUserFailed(baseResponse: response));
      }
    } catch (e) {
      if (e is PlatformException) {
        if (e.message != null) {
          emit(EditUserFailed(baseResponse: e.details as BaseResponse));
        }
        emit(
          EditUserFailed(
            baseResponse: BaseResponse(
              errorMessage: AppStrings.somethingWentWrong.tr(),
            ),
          ),
        );
      }
    }
  }
}
