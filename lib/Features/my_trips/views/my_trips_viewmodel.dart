import 'package:flutter/material.dart';

import '../../../app/app_prefs.dart';
import '../../../app/di.dart';

class MyTripsViewModel {
  final AppPreferences appPreferences = instance<AppPreferences>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool displayLoadingIndicator = false;
  List<bool> selections = [true, false];
  int selectedIndex = 0;
  int upcomingTripType = 5;
  int pastTripType = 4;
}
