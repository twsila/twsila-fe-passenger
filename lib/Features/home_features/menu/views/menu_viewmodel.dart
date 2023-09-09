import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/base/baseviewmodel.dart';
import 'package:taxi_for_you/data/model/user-model.dart';

import '../../../../app/app_prefs.dart';
import '../../../../app/di.dart';

class MenuViewModel extends BaseViewModel {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final AppPreferences appPreferences = instance<AppPreferences>();
  late UserModel userModel;
  late BuildContext context;

  @override
  void start() {
    UserModel? user = appPreferences.getUserData();
    if (user != null) {
      userModel = user;
    } else {
      appPreferences.logout(context);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
