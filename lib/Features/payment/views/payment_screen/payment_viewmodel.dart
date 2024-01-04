import 'package:flutter/material.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/di.dart';

class PaymentViewModel {
  final AppPreferences appPreferences = instance();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardHolderController = TextEditingController();
  TextEditingController cardExpiryDateController = TextEditingController();
  TextEditingController cardCVVController = TextEditingController();
}
