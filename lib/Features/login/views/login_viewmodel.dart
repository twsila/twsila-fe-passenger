import 'package:flutter/material.dart';

import '../../base/baseviewmodel.dart';

class LoginViewModel extends BaseViewModel {
  TextEditingController phoneController = TextEditingController();
  String? countryCode;
  late String country;

  // inputs
  @override
  void dispose() {}

  @override
  void start() {}
}
