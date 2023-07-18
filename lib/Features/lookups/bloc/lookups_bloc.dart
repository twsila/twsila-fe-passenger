import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:taxi_for_you/Features/lookups/bloc/lookups_event.dart';
import 'package:taxi_for_you/Features/lookups/bloc/lookups_state.dart';
import 'package:taxi_for_you/Features/lookups/model/lookups_repo.dart';

import '../../../../core/network/base_response.dart';

class LookupsBloc extends Bloc<LookupsEvent, LookupsStates> {
  final LookupsRepo lookupsRepo;

  LookupsBloc(this.lookupsRepo) : super(LookupsIsNotLoading()) {
    on<GetLookups>(_getLookups);
  }

  void _getLookups(GetLookups event, Emitter<LookupsStates> emit) async {
    emit(LookupsIsLoading());

    try {
      BaseResponse baseResponse = await lookupsRepo.getLookups();

      emit(LookupsSuccessfully());
    } catch (e) {
      if (e is PlatformException) {
        if (e.message != null) {
          emit(LookupsFailed(
              baseResponse: BaseResponse(errorMessage: e.message)));
        }
      } else {
        var response = BaseResponse(errorMessage: e.toString());
        emit(LookupsFailed(baseResponse: response));
      }
    }
  }
}
