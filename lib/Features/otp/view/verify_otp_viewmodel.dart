import 'package:flutter/material.dart';

class VerifyOTPViewModel {
  late String mobileNumber;
  late String countryCode;
  TextEditingController mobileController = TextEditingController();

  start(Map arguments) {
    if (arguments["mobile"] != null) {
      mobileNumber = arguments["mobile"];
    }
    if (arguments["countryCode"] != null) {
      countryCode = arguments["countryCode"];
    }
  }

  disponse() {
    mobileController.dispose();
  }
}
