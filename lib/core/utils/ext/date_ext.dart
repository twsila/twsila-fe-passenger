import 'package:easy_localization/easy_localization.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/di.dart';

extension DateFormatString on String {
  String formatStringToDateString() {
    final AppPreferences _appPrefs = instance<AppPreferences>();
    return DateFormat('dd MMM yyyy/ hh:mm a', _appPrefs.getAppLanguage())
        .format(DateFormat('dd/MM/yyyy hh:mm:ss').parse(this));
  }
}
