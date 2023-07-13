import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:taxi_for_you/Features/trip_details/bloc/trip_details_event.dart';
import 'package:taxi_for_you/Features/trip_details/bloc/trip_details_state.dart';
import 'package:taxi_for_you/Features/trip_details/model/trip_details_model.dart';
import 'package:taxi_for_you/Features/trip_details/model/trip_details_repo.dart';

import '../../../../core/network/base_response.dart';

class TripDetailsBloc extends Bloc<TripDetailsEvent, TripDetailsStates> {
  final TripDetailsRepo tripDetailsRepo;

  TripDetailsBloc(this.tripDetailsRepo) : super(TripDetailsIsNotLoading()) {
    on<GetTripDetailsRequest>(_getTripDetails);
    on<CancelTripRequest>(_cancelTrip);
  }

  void _getTripDetails(
      GetTripDetailsRequest event, Emitter<TripDetailsStates> emit) async {
    emit(TripDetailsIsLoading());

    try {
      BaseResponse baseResponse =
          await tripDetailsRepo.getTripDetailsRequest(event.tripId);

      TripDetailsModel tripDetailsModel =
          TripDetailsModel.fromJson(baseResponse.result);

      emit(TripDetailsSuccessfully(
        tripDetailsModel: tripDetailsModel,
      ));
    } catch (e) {
      if (e is PlatformException) {
        if (e.message != null) {
          emit(TripDetailsFailed(
              baseResponse: BaseResponse(errorMessage: e.message)));
        }
      } else {
        var response = BaseResponse(errorMessage: e.toString());
        emit(TripDetailsFailed(baseResponse: response));
      }
    }
  }

  void _cancelTrip(
      CancelTripRequest event, Emitter<TripDetailsStates> emit) async {
    emit(TripDetailsIsLoading());

    try {
      await tripDetailsRepo.cancelTripRequest(event.tripId);

      emit(CancelTripSuccessfully());
    } catch (e) {
      if (e is PlatformException) {
        if (e.message != null) {
          emit(CancelTripFailed(
              baseResponse: BaseResponse(errorMessage: e.message)));
        }
      } else {
        var response = BaseResponse(errorMessage: e.toString());
        emit(CancelTripFailed(baseResponse: response));
      }
    }
  }
}
