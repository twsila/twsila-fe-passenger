import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:taxi_for_you/Features/home/bloc/home_bloc.dart';
import 'package:taxi_for_you/Features/home/model/home_repo.dart';
import 'package:taxi_for_you/Features/login/bloc/login_bloc.dart';
import 'package:taxi_for_you/Features/login/model/login_repo.dart';
import 'package:taxi_for_you/Features/lookups/bloc/lookups_bloc.dart';
import 'package:taxi_for_you/Features/lookups/model/lookups_repo.dart';
import 'package:taxi_for_you/Features/my_trips/bloc/my_trips_bloc.dart';
import 'package:taxi_for_you/Features/my_trips/model/my_trips_repo.dart';
import 'package:taxi_for_you/Features/otp/bloc/otp_bloc.dart';
import 'package:taxi_for_you/Features/otp/model/otp_repo.dart';
import 'package:taxi_for_you/Features/registeration/bloc/registeration_bloc.dart';
import 'package:taxi_for_you/Features/registeration/models/registeration_repo.dart';
import 'package:taxi_for_you/Features/request_service/bloc/draft_trip_bloc.dart';
import 'package:taxi_for_you/Features/request_service/model/draft_trip_repo.dart';
import 'package:taxi_for_you/Features/trip_details/bloc/trip_details_bloc.dart';
import 'package:taxi_for_you/Features/trip_details/model/trip_details_repo.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/di.dart';

import '../Features/google_maps/bloc/maps_bloc.dart';
import '../Features/google_maps/model/maps_repo.dart';
import '../Features/transportation_requests/bloc/transportation_bloc.dart';
import '../Features/transportation_requests/model/transportation_repo.dart';
import '../core/utils/location/map_provider.dart';

blocProviders(BuildContext context) {
  return [
    BlocProvider.value(
      value: LoginBloc(instance<LoginRepo>(), instance<AppPreferences>()),
    ),
    BlocProvider.value(
      value: RegistrationBloc(
        instance<RegistrationRepo>(),
        instance<AppPreferences>(),
      ),
    ),
    BlocProvider.value(
      value: HomeBloc(instance<HomeRepo>(), instance<AppPreferences>()),
    ),
    BlocProvider.value(
      value: TransportationBloc(
          instance<TransportationRepo>(), instance<AppPreferences>()),
    ),
    BlocProvider.value(value: TripDetailsBloc(instance<TripDetailsRepo>())),
    BlocProvider.value(value: DraftTripBloc(instance<DraftTripRepo>())),
    BlocProvider.value(value: MyTripsBloc(instance<MyTripsRepo>())),
    BlocProvider.value(value: LookupsBloc(instance<LookupsRepo>())),
    BlocProvider.value(value: OtpBloc(instance<OtpRepo>())),
    BlocProvider.value(value: MapsBloc(MapsRepo())),
    ChangeNotifierProvider(create: (_) => MapProvider()),
  ];
}
