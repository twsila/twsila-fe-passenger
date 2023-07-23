import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:taxi_for_you/Features/transportation_requests/bloc/transportation_event.dart';
import 'package:taxi_for_you/Features/transportation_requests/bloc/transportation_state.dart';
import 'package:taxi_for_you/Features/transportation_requests/model/transportation_base_model.dart';
import 'package:taxi_for_you/Features/trip_details/model/trip_details_model.dart';

import '../../../../app/app_prefs.dart';
import '../../../../core/network/base_response.dart';
import '../model/transportation_repo.dart';

class TransportationBloc
    extends Bloc<TransportationEvent, TransportationRequestStates> {
  final TransportationRepo transportationRepo;
  final AppPreferences appPreferences;

  TransportationBloc(this.transportationRepo, this.appPreferences)
      : super(TransportationRequestIsNotLoading()) {
    on<SendTransportationRequest>(_sendTransportationRequest);
    on<GetDraftTrip>(_getDraftTripRequest);
  }

  void _sendTransportationRequest(SendTransportationRequest event,
      Emitter<TransportationRequestStates> emit) async {
    emit(TransportationRequestIsLoading());

    try {
      BaseResponse baseResponse =
          await (transportationRepo.sendTransportationRequest(
        event.endPoint,
        event.files,
        event.body,
      ));

      int tripId = baseResponse.result;
      var body = event.body;
      body['tripId'] = tripId;
      body['tripEndPoint'] = event.endPoint;

      emit(TransportationRequestSuccessfully(
        tripId: tripId,
        transportationBaseModel: event.transportationBaseModel,
        body: body,
        endPoint: event.endPoint,
      ));
    } catch (e) {
      if (e is PlatformException) {
        if (e.message != null) {
          emit(TransportationRequestFailed(
              baseResponse: BaseResponse(errorMessage: e.message)));
        }
      } else {
        var response = BaseResponse(errorMessage: e.toString());
        emit(TransportationRequestFailed(baseResponse: response));
      }
    }
  }

  void _getDraftTripRequest(
      GetDraftTrip event, Emitter<TransportationRequestStates> emit) async {
    emit(TransportationRequestIsLoading());

    try {
      BaseResponse baseResponse = await (transportationRepo.getDraftTrip());

      TripDetailsModel tripDetailsModel =
          TripDetailsModel.fromJson(baseResponse.result);

      emit(DraftTripSuccessfully(
        transportationBaseModel: tripDetailsModel,
      ));
    } catch (e) {
      if (e is PlatformException) {
        if (e.message != null) {
          emit(TransportationRequestFailed(
              baseResponse: BaseResponse(errorMessage: e.message)));
        }
      } else {
        var response = BaseResponse(errorMessage: e.toString());
        emit(TransportationRequestFailed(baseResponse: response));
      }
    }
  }
}
