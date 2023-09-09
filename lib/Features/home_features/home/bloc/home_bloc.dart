import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import '../../../../app/app_prefs.dart';
import '../../../../core/network/base_response.dart';
import '../model/home_repo.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvents, HomeStates> {
  final HomeRepo homeRepo;
  final AppPreferences appPreferences;

  HomeBloc(this.homeRepo, this.appPreferences) : super(LogoutIsNotLoading()) {
    on<LogoutUser>(_logoutUser);
  }

  void _logoutUser(LogoutUser event, Emitter<HomeStates> emit) async {
    emit(LogoutIsLoading());

    try {
      BaseResponse response = await (homeRepo.logoutUser());
      if (response.success != null && response.success!) {
        appPreferences.logout(event.context);
        emit(LogoutSuccessfully());
      } else {
        emit(LogoutFailed(baseResponse: response));
      }
    } catch (e) {
      if (e is PlatformException) {
        if (e.message != null && e.details != null) {
          emit(LogoutFailed(baseResponse: e.details as BaseResponse));
        }
      } else {
        var response = BaseResponse(errorMessage: e.toString());
        emit(LogoutFailed(baseResponse: response));
      }
    }
  }
}
