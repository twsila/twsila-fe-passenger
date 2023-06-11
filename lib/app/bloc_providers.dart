import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:taxi_for_you/Features/login/bloc/login_bloc.dart';
import 'package:taxi_for_you/Features/login/model/login_repo.dart';
import 'package:taxi_for_you/Features/other/car_aid_view/bloc/car_aid_bloc.dart';
import 'package:taxi_for_you/Features/other/car_aid_view/models/car_aid_repo.dart';
import 'package:taxi_for_you/Features/other/furniture_view/bloc/furniture_bloc.dart';
import 'package:taxi_for_you/Features/other/furniture_view/models/furniture_repo.dart';
import 'package:taxi_for_you/Features/other/goods_view/bloc/goods_bloc.dart';
import 'package:taxi_for_you/Features/other/goods_view/models/goods_repo.dart';
import 'package:taxi_for_you/Features/otp/bloc/otp_bloc.dart';
import 'package:taxi_for_you/Features/otp/model/otp_repo.dart';
import 'package:taxi_for_you/Features/registeration/bloc/registeration_bloc.dart';
import 'package:taxi_for_you/Features/registeration/models/registeration_repo.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/di.dart';

import '../Features/google_maps/bloc/maps_bloc.dart';
import '../Features/google_maps/model/maps_repo.dart';
import '../core/utils/location/map_provider.dart';

blocProviders(BuildContext context) {
  return [
    BlocProvider.value(
        value: LoginBloc(instance<LoginRepo>(), instance<AppPreferences>())),
    BlocProvider.value(
        value: FurnitureBloc(
            instance<FurnitureRepo>(), instance<AppPreferences>())),
    BlocProvider.value(
        value: GoodsBloc(instance<GoodsRepo>(), instance<AppPreferences>())),
    BlocProvider.value(
        value: CarAidBloc(instance<CarAidRepo>(), instance<AppPreferences>())),
    BlocProvider.value(value: RegistrationBloc(instance<RegistrationRepo>())),
    BlocProvider.value(value: OtpBloc(instance<OtpRepo>())),
    BlocProvider.value(value: MapsBloc(MapsRepo())),
    ChangeNotifierProvider(create: (_) => MapProvider()),
  ];
}
