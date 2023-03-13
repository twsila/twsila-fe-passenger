import 'package:flutter/material.dart';

import '../../app/app_prefs.dart';
import '../../app/di.dart';
import '../../data/data_source/local_data_source.dart';
import '../../utils/resources/routes_manager.dart';

class CategoriesViewModel {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final LocalDataSource _localDataSource = instance<LocalDataSource>();

  void logout(BuildContext context) {
    // app prefs make that user logged out
    _appPreferences.logout();

    // clear cache of logged out user
    _localDataSource.clearCache();

    // navigate to login screen
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }
}
