import 'package:easy_localization/easy_localization.dart';
import 'package:taxi_for_you/app/app_prefs.dart';

import '../../../app/di.dart';

class DateHelper {
  static String formatDateTime({
    String pattern = 'EEEE dd MMM yyyy / hh:mm a',
    DateTime? dateTime,
  }) {
    final AppPreferences _appPrefs = instance();
    return DateFormat(pattern).format(dateTime ?? DateTime.now());
  }

  static String currentDateTimeString({String pattern = 'dd/MM/yyyy hh:mm a'}) {
    return DateFormat(pattern).format(DateTime.now());
  }

  static DateTime currentDateTime() {
    return DateTime.now();
  }
}
