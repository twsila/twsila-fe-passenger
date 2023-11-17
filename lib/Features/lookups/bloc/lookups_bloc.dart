import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:taxi_for_you/Features/lookups/bloc/lookups_event.dart';
import 'package:taxi_for_you/Features/lookups/bloc/lookups_state.dart';
import 'package:taxi_for_you/Features/lookups/model/lookups_model.dart';
import 'package:taxi_for_you/Features/lookups/model/lookups_repo.dart';
import 'package:taxi_for_you/Features/lookups/model/models/vehicle_type.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/data/model/country.dart';

import '../../../../core/network/base_response.dart';

class LookupsBloc extends Bloc<LookupsEvent, LookupsStates> {
  final LookupsRepo lookupsRepo;
  final AppPreferences appPreferences;

  LookupsBloc(this.lookupsRepo, this.appPreferences)
      : super(LookupsIsNotLoading()) {
    on<GetLookups>(_getLookups);
    on<GetLookupsByKey>(_getLookupsByKey);
    on<GetCountriesLookup>(_getCountriesLookups);
  }

  void _getLookups(GetLookups event, Emitter<LookupsStates> emit) async {
    emit(LookupsIsLoading());

    try {
      BaseResponse baseResponse = await lookupsRepo.getLookups();

      LookupsModel.saveLookups(baseResponse.result);

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

  void _getLookupsByKey(
      GetLookupsByKey event, Emitter<LookupsStates> emit) async {
    emit(LookupsIsLoading());

    try {
      BaseResponse baseResponse =
          await lookupsRepo.getLookupsByKey(event.lookupKey);

      VehicleTypes.saveVehicle(baseResponse.result);

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

  void _getCountriesLookups(
      GetCountriesLookup event, Emitter<LookupsStates> emit) async {
    emit(LookupsIsLoading());

    try {
      BaseResponse baseResponse = await lookupsRepo.getCountriesLookups();

      List<CountryModel> countries = List<CountryModel>.from(
        baseResponse.result.map(
          (x) => CountryModel.fromJson(x),
        ),
      );

      appPreferences.setCountries(countries);

      emit(LookupCountiresSuccessfully());
    } catch (e) {
      if (e is PlatformException) {
        if (e.message != null) {
          emit(LookupCountiresFailed(
              baseResponse: BaseResponse(errorMessage: e.message)));
        }
      } else {
        var response = BaseResponse(errorMessage: e.toString());
        emit(LookupCountiresFailed(baseResponse: response));
      }
    }
  }
}
