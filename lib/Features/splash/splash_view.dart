import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../app/app_prefs.dart';
import '../../app/di.dart';
import '../../core/utils/location/map_provider.dart';
import '../../core/utils/resources/assets_manager.dart';
import '../../core/utils/resources/color_manager.dart';
import '../../core/utils/resources/routes_manager.dart';
import '../../data/model/user-model.dart';
import '../common/state_renderer/dialogs.dart';
import '../google_maps/bloc/maps_bloc.dart';
import '../google_maps/bloc/maps_events.dart';
import '../google_maps/bloc/maps_state.dart';
import '../login/bloc/login_bloc.dart';
import '../login/bloc/login_event.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool _isInit = true;
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isInit = false;
      setCountry();
    }
    super.didChangeDependencies();
  }

  getCurrentLocation() async {
    BlocProvider.of<MapsBloc>(context, listen: false).add(GetCurrentLocation());
  }

  setCountry() {
    Provider.of<MapProvider>(context, listen: false)
        .setCountry(null, needsRebuild: false);
  }

  _goNext() async {
    _appPreferences.isUserLoggedIn().then((isUserLoggedIn) {
      if (isUserLoggedIn) {
        // navigate to main screen
        UserModel? user = _appPreferences.getUserData();
        if (user != null) {
          BlocProvider.of<LoginBloc>(context)
              .add(LoginUser(mobileNumber: user.mobileNumber!));
        } else {
          Navigator.pushReplacementNamed(context, Routes.loginRoute);
        }
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
                return const SizedBox();
              }),
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
