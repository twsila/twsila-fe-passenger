// ignore_for_file: constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/data_source/local_data_source.dart';
import '../utils/resources/langauge_manager.dart';
import 'di.dart';

const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
const String PREFS_KEY_ONBOARDING_SCREEN_VIEWED =
    "PREFS_KEY_ONBOARDING_SCREEN_VIEWED";
const String PREFS_KEY_IS_USER_LOGGED_IN = "PREFS_KEY_IS_USER_LOGGED_IN";
const String USER_SELECTED_COUNTRY = "USER_SELECTED_COUNTRY";
const String USER_MOBILE_NUMBER = "USER_MOBILE_NUMBER";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  String getAppLanguage() {
    String? language = _sharedPreferences.getString(PREFS_KEY_LANG);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      // return default lang
      return LanguageType.ENGLISH.getValue();
    }
  }

  Future<void> changeAppLanguage() async {
    String currentLang = getAppLanguage();

    if (currentLang == LanguageType.ARABIC.getValue()) {
      // set english
      _sharedPreferences.setString(
          PREFS_KEY_LANG, LanguageType.ENGLISH.getValue());
    } else {
      // set arabic
      _sharedPreferences.setString(
          PREFS_KEY_LANG, LanguageType.ARABIC.getValue());
    }
  }

  Future<Locale> getLocal() async {
    String currentLang = getAppLanguage();

    if (currentLang == LanguageType.ARABIC.getValue()) {
      return ARABIC_LOCAL;
    } else {
      return ENGLISH_LOCAL;
    }
  }

  //Selected country
  setUserSelectedCountry(String country) {
    _sharedPreferences.setString(USER_SELECTED_COUNTRY, country);
  }

  String? getUserSelectedCountry() {
    return _sharedPreferences.getString(USER_SELECTED_COUNTRY);
  }

  //Set User Devices
  setUserDevices(String mobileNumber) {
    List<String>? mobileNumbers =
        _sharedPreferences.getStringList(USER_MOBILE_NUMBER);
    if (mobileNumbers == null) {
      mobileNumbers = [mobileNumber];
    } else {
      mobileNumbers.add(mobileNumber);
    }
    _sharedPreferences.setStringList(USER_MOBILE_NUMBER, mobileNumbers);
  }

  bool getUserDevice(String mobileNumber) {
    List<String>? mobileNumbers =
        _sharedPreferences.getStringList(USER_MOBILE_NUMBER);
    if (mobileNumbers == null) {
      return false;
    } else {
      int index = mobileNumbers.indexOf(mobileNumber);
      return index == -1 ? false : true;
    }
  }

  // on boarding

  Future<void> setOnBoardingScreenViewed() async {
    _sharedPreferences.setBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED, true);
  }

  Future<bool> isOnBoardingScreenViewed() async {
    return _sharedPreferences.getBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED) ??
        false;
  }

  //login

  Future<void> setUserLoggedIn() async {
    _sharedPreferences.setBool(PREFS_KEY_IS_USER_LOGGED_IN, true);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(PREFS_KEY_IS_USER_LOGGED_IN) ?? false;
  }

  Future<void> logout(BuildContext context) async {
    final LocalDataSource _localDataSource = instance<LocalDataSource>();
    await FirebaseAuth.instance.signOut();

    // clear cache of logged out user
    _localDataSource.clearCache();

    _sharedPreferences.remove(PREFS_KEY_IS_USER_LOGGED_IN);

    Phoenix.rebirth(context);
  }
}
