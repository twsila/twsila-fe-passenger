import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension DateString on BuildContext {
  String formatDateTime({
    String pattern = 'dd/MM/yyyy hh:mm a',
    DateTime? dateTime,
  }) {
    return DateFormat(pattern).format(dateTime ?? DateTime.now());
  }

  String currentDateTimeString({String pattern = 'dd/MM/yyyy hh:mm a'}) {
    return DateFormat(pattern).format(DateTime.now());
  }

  DateTime currentDateTime() {
    return DateTime.now();
  }
}
