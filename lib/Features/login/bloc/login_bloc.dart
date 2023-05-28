import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:taxi_for_you/data/model/user-model.dart';

import '../../../app/app_prefs.dart';
import '../../../core/network/base_response.dart';
import '../model/login_repo.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginStates> {
  final LoginRepo loginRepo;
  final AppPreferences appPreferences;

  LoginBloc(this.loginRepo, this.appPreferences) : super(LoginIsNotLoading()) {
    on<LoginUser>(_loginUser);
  }

  void _loginUser(LoginUser event, Emitter<LoginStates> emit) async {
    emit(LoginIsLoading());

    try {
      BaseResponse response = await (loginRepo.loginUser(event.mobileNumber));
      if (response.result != null &&
          response.success != null &&
          response.success!) {
        dynamic results = response.result;
        UserModel userModel = UserModel.fromJson(results);
        appPreferences.setUserLoggedIn(userModel);
        emit(LoginSuccessfully(userModel));
      } else {
        emit(LoginFailed(baseResponse: response));
      }
    } catch (e) {
      if (e is PlatformException) {
        if (e.message != null) {
          emit(LoginFailed(baseResponse: e.details as BaseResponse));
        }
      }
    }
  }
}
