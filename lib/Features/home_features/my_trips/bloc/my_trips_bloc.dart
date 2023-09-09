import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:taxi_for_you/Features/home_features/my_trips/bloc/my_trips_event.dart';
import 'package:taxi_for_you/Features/home_features/my_trips/bloc/my_trips_state.dart';
import 'package:taxi_for_you/Features/home_features/my_trips/model/my_trips_repo.dart';

import '../../../../../core/network/base_response.dart';
import '../../../trip_details/model/trip_details_model.dart';

class MyTripsBloc extends Bloc<MyTripsEvent, MyTripsStates> {
  final MyTripsRepo myTripsRepo;

  MyTripsBloc(this.myTripsRepo) : super(MyTripsIsNotLoading()) {
    on<GetUserTrips>(_getUserTrips);
  }

  void _getUserTrips(GetUserTrips event, Emitter<MyTripsStates> emit) async {
    emit(MyTripsIsLoading());

    try {
      BaseResponse baseResponse =
          await myTripsRepo.getUserTripsRequest(event.tripModelType);

      List<TripDetailsModel> trips = List<TripDetailsModel>.from(
          baseResponse.result.map((x) => TripDetailsModel.fromJson(x)));

      emit(MyTripsSuccessfully(
        trips: trips,
      ));
    } catch (e) {
      if (e is PlatformException) {
        if (e.message != null) {
          emit(MyTripsFailed(
              baseResponse: BaseResponse(errorMessage: e.message)));
        }
      } else {
        var response = BaseResponse(errorMessage: e.toString());
        emit(MyTripsFailed(baseResponse: response));
      }
    }
  }
}
