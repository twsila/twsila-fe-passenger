import 'package:bloc/bloc.dart';

import '../model/location_model.dart';
import '../model/maps_repo.dart';
import 'maps_events.dart';
import 'maps_state.dart';

class MapsBloc extends Bloc<MapsEvents, MapsState> {
  MapsRepo mapsRepo = MapsRepo();

  MapsBloc(this.mapsRepo) : super(CurrentLocationIsNotLoading()) {
    on<GetCurrentLocationEvent>(_getCurrentLocation);
  }

  void _getCurrentLocation(
      GetCurrentLocationEvent event, Emitter<MapsState> emit) async {
    emit(CurrentLocationIsLoading());

    try {
      LocationModel location = await mapsRepo.getUserCurrentLocation();
      emit(CurrentLocationLoadedSuccessfully(currentLocation: location));
    } catch (e) {
      emit(CurrentLocationFailed(errorMessage: e.toString()));
    }
  }
}
