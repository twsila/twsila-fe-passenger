import 'dart:async';

import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/base/baseviewmodel.dart';

class TripDetailsViewModel extends BaseViewModel {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late Timer _timer;
  bool displayLoadingIndicator = false;
  bool isInit = true;
  bool condition = true;

  @override
  void start() {}

  @override
  void dispose() {
    cancelTimer();
  }

  setTimer(Function function) {
    Future.delayed(const Duration(seconds: 30), () => condition = false);
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (condition == false) {
        _timer.cancel();
        return;
      }
      function();
    });
  }

  cancelTimer() {
    if (_timer.isActive) _timer.cancel();
  }
}
