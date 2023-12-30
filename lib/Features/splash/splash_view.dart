import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:taxi_for_you/Features/common/widgets/custom_reload_widget.dart';
import 'package:taxi_for_you/Features/login/bloc/login_state.dart';
import 'package:taxi_for_you/Features/lookups/bloc/lookups_bloc.dart';
import 'package:taxi_for_you/Features/lookups/bloc/lookups_event.dart';
import 'package:taxi_for_you/Features/lookups/bloc/lookups_state.dart';
import 'package:taxi_for_you/Features/lookups/model/lookups_model.dart';
import 'package:taxi_for_you/core/utils/location/user_current_location.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';
import '../../app/app_prefs.dart';
import '../../app/di.dart';
import '../../core/utils/firebase_messaging/firebase_messaging_helper.dart';
import '../../core/utils/location/map_provider.dart';
import '../../core/utils/resources/assets_manager.dart';
import '../../core/utils/resources/color_manager.dart';
import '../../core/utils/resources/routes_manager.dart';
import '../../data/model/user-model.dart';
import '../common/state_renderer/dialogs.dart';
import '../login/bloc/login_bloc.dart';
import '../login/bloc/login_event.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  UserModel? user;
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void initState() {
    super.initState();
    start();
  }

  start() async {
    user = _appPreferences.getUserData();
    UserLocationService().checkLocationPermission();
    await FirebaseMessagingHelper().configure();
    if (user != null) {
      refreshToken();
    } else {
      getLookups();
    }
  }

  refreshToken() {
    BlocProvider.of<LoginBloc>(context)
        .add(LoginUser(mobileNumber: user!.mobileNumber!));
  }

  getLookups() {
    BlocProvider.of<LookupsBloc>(context).add(GetLookups());
    BlocProvider.of<LookupsBloc>(context).add(GetCountriesLookup());
  }

  _goNext() {
    _appPreferences.isUserLoggedIn().then((isUserLoggedIn) {
      if (isUserLoggedIn) {
        // navigate to main screen
        Navigator.pushReplacementNamed(context, Routes.homeRoute);
      } else {
        // Navigate to Login Screen
        Navigator.pushReplacementNamed(context, Routes.loginRoute);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(ImageAssets.logoImg),
            const SizedBox(height: 16),
            BlocConsumer<LoginBloc, LoginStates>(
              listener: ((context, state) {
                if (state is LoginFailed) {
                  ShowDialogHelper.showErrorMessage(
                    state.baseResponse.errorMessage ??
                        AppStrings.noInternetError.tr(),
                    context,
                  );
                } else if (state is LoginSuccessfully) {
                  getLookups();
                }
              }),
              builder: ((context, state) {
                if (state is LoginFailed) {
                  return CustomReloadWidget(onPressed: () => start());
                }
                return const SizedBox();
              }),
            ),
            BlocConsumer<LookupsBloc, LookupsStates>(
              listener: ((context, state) {
                if (state is LookupsFailed) {
                  ShowDialogHelper.showErrorMessage(
                    state.baseResponse.errorMessage ??
                        AppStrings.noInternetError.tr(),
                    context,
                  );
                } else if (state is LookupsSuccessfully) {
                  _goNext();
                }
              }),
              builder: ((context, state) {
                if (state is LookupsFailed) {
                  return CustomReloadWidget(onPressed: () => start());
                }
                return const SizedBox();
              }),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
