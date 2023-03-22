import 'package:flutter/material.dart';

import '../../app/app_prefs.dart';
import '../../app/di.dart';

class CategoriesViewModel {
  final AppPreferences _appPreferences = instance<AppPreferences>();

  void logout(BuildContext context) {
    // app prefs make that user logged out
    _appPreferences.logout(context);
  }
}
