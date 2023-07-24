import 'package:flutter/material.dart';

import '../../../app/app_prefs.dart';
import '../../../app/di.dart';
import '../../menu/views/menu_screen.dart';
import '../../my_trips/views/my_trips_screen.dart';
import '../../request_service/views/request_service_screen.dart';

class HomeViewModel {
  int selectedIndex = 0;
  bool displayLoadingIndicator = false;
  AppPreferences appPreferences = instance<AppPreferences>();
  List<Widget> screens = [
    const MenuScreen(),
    const RequestServiceScreen(),
    const MyTripsScreen(),
  ];
}
