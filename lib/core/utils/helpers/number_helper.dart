import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/di.dart';

import '../resources/langauge_manager.dart';

class LanguageNumbersHelper {
  String replaceArabicNumber(String input) {
    AppPreferences appPreferences = instance();
    String applang = appPreferences.getAppLanguage();

    if (applang == LanguageType.ARABIC.getValue()) {
      const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
      const arabic = ['۰', '۱', '۲', '۳', '٤', '٥', '٦', '٧', '٨', '٩'];

      for (int i = 0; i < english.length; i++) {
        input = input.replaceAll(english[i], arabic[i]);
      }

      return input;
    } else {
      return input;
    }
  }
}
