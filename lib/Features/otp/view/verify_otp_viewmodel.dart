import 'package:flutter/material.dart';

class VerifyOTPViewModel {
  late String mobileNumber;
  TextEditingController mobileController = TextEditingController();

  disponse() {
    mobileController.dispose();
  }
}
