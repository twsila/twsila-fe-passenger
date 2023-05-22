import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:taxi_for_you/Features/login/bloc/login_bloc.dart';
import 'package:taxi_for_you/Features/login/model/login_repo.dart';
import 'package:taxi_for_you/Features/otp/bloc/otp_bloc.dart';
import 'package:taxi_for_you/Features/otp/model/otp_repo.dart';
import 'package:taxi_for_you/app/di.dart';

import '../Features/google_maps/bloc/maps_bloc.dart';
import '../Features/google_maps/model/maps_repo.dart';
import '../core/utils/location/map_provider.dart';

blocProviders(BuildContext context) {
  return [
    BlocProvider.value(value: LoginBloc(instance<LoginRepo>())),
    BlocProvider.value(value: OtpBloc(instance<OtpRepo>())),
    BlocProvider.value(value: MapsBloc(MapsRepo())),
    ChangeNotifierProvider(create: (_) => MapProvider()),
  ];
}
