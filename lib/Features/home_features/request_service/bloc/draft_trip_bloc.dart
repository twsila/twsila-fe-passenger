import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:taxi_for_you/Features/home_features/request_service/bloc/draft_trip_event.dart';
import 'package:taxi_for_you/Features/home_features/request_service/bloc/draft_trip_state.dart';
import 'package:taxi_for_you/Features/home_features/request_service/model/draft_trip_repo.dart';
import 'package:taxi_for_you/Features/trip_details/model/trip_details_model.dart';

import '../../../../../core/network/base_response.dart';

class DraftTripBloc extends Bloc<DraftTripEvent, DraftTripStates> {
  final DraftTripRepo draftTripRepo;

  DraftTripBloc(
    this.draftTripRepo,
  ) : super(DraftTripIsNotLoading()) {
    on<GetDraftTrip>(_getDraftTripRequest);
  }

  void _getDraftTripRequest(
      GetDraftTrip event, Emitter<DraftTripStates> emit) async {
    emit(DraftTripIsLoading());

    try {
      BaseResponse baseResponse = await draftTripRepo.getDraftTrip();

      TripDetailsModel tripDetailsModel =
          TripDetailsModel.fromJson(baseResponse.result);

      emit(DraftTripSuccessfully(
        transportationBaseModel: tripDetailsModel,
      ));
    } catch (e) {
      if (e is PlatformException) {
        if (e.message != null) {
          emit(DraftTripFailed(
              baseResponse: BaseResponse(errorMessage: e.message)));
        }
      } else {
        var response = BaseResponse(errorMessage: e.toString());
        emit(DraftTripFailed(baseResponse: response));
      }
    }
  }
}
