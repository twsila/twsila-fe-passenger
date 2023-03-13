import 'dart:async';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:taxi_for_you/presentation/google_maps/helpers/map_provider.dart';
import '../../app/app_prefs.dart';
import '../../app/di.dart';
import '../../utils/resources/assets_manager.dart';
import '../../utils/resources/color_manager.dart';
import '../../utils/resources/constants_manager.dart';
import '../../utils/resources/routes_manager.dart';
import '../../utils/resources/strings_manager.dart';
import '../common/state_renderer/dialogs.dart';
import '../google_maps/bloc/maps_bloc.dart';
import '../google_maps/bloc/maps_events.dart';
import '../google_maps/bloc/maps_state.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  getCurrentLocation() async {
    BlocProvider.of<MapsBloc>(context, listen: false).add(GetCurrentLocation());
  }

  _goNext() async {
    _appPreferences.isUserLoggedIn().then((isUserLoggedIn) => {
          if (isUserLoggedIn)
            {
              // navigate to main screen
              Navigator.pushReplacementNamed(context, Routes.mainRoute)
            }
          else
            {
              // Navigate to Login Screen
              Navigator.pushReplacementNamed(context, Routes.loginRoute)
              // Navigator.pushReplacementNamed(context, Routes.categoriesRoute)
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
            Column(
              children: [
                Text(
                  AppStrings.appTitle.tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                BlocConsumer<MapsBloc, MapsState>(
                  listener: ((context, state) {
                    if (state is CurrentLocationFailed) {
                      ShowDialogHelper.showErrorMessage(
                          state.errorMessage, context);
                      _goNext();
                    } else if (state is CurrentLocationLoadedSuccessfully) {
                      Provider.of<MapProvider>(context, listen: false)
                          .currentLocation = state.currentLocation;
                      _goNext();
                    }
                  }),
                  builder: ((context, state) {
                    if (state is CurrentLocationIsLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: ColorManager.primary,
                          color: Colors.blue,
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),
                )
              ],
            )
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
