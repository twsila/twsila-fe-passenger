import 'dart:async';

import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/base/baseviewmodel.dart';

class TripDetailsViewModel extends BaseViewModel {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Timer? _timer;
  bool displayLoadingIndicator = false;
  bool isInit = true;

  @override
  void start() {}

  @override
  void dispose() {
    cancelTimer();
  }

  bool timerIsActive() {
    return (_timer != null && _timer!.isActive);
  }

  setTimer(Function function) {
    if (timerIsActive()) return;
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      function();
    });
  }

  cancelTimer() {
    if (_timer != null && _timer!.isActive) _timer!.cancel();
  }
}
