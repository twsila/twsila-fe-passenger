// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_for_you/Features/login/model/login_repo.dart';
import 'package:taxi_for_you/Features/lookups/model/lookups_model.dart';
import 'package:taxi_for_you/app/constants.dart';
import 'package:taxi_for_you/app/di.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';
import 'package:taxi_for_you/data/model/auth.dart';
import 'package:taxi_for_you/data/model/country.dart';
import 'package:taxi_for_you/data/model/user-model.dart';
import '../core/utils/resources/langauge_manager.dart';

const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
const String USER_MODEL = "USER_MODEL";
const String AUTH_TOKEN = "AUTH";
const String USER_FCM_TOKEN = "USER_FCM_TOKEN";
const String USER_MOBILE_NUMBER = "USER_MOBILE_NUMBER";
const String FURNITURE_TRIP = "FURNITURE_TRIP";
const String GOODS_TRIP = "GOODS_TRIP";
const String FREEZERS_TRIP = "FREEZERS_TRIP";
const String CISTERNS_TRIP = "CISTERNS_TRIP";
const String CAR_AID_TRIP = "CAR_AID_TRIP";
const String WATER_TRIP = "WATER_TRIP";
const String PERSON_TRIP = "PERSON_TRIP";

class AppPreferences {
  final SharedPreferences _sharedPreferences;
  List<CountryModel> _countries = [];
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

  bool isEnglish() {
    return getAppLanguage() == LanguageType.ENGLISH.getValue();
  }

  LookupModel getLookupsInstance() {
    return instance.get<LookupModel>(instanceName: GetItInstanceNames.lookups);
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

  //User Country
  setCountries(List<CountryModel> countries) {
    _countries = countries;
  }

  List<CountryModel> getCountries() {
    return _countries;
  }

  String? getUserCountry() {
    UserModel? user = getUserData();
    if (user != null) {
      return user.countryCode;
    } else {
      return null;
    }
  }

  String getCurrentCurrnecy() {
    return getUserCountry() == "SA"
        ? AppStrings.saudiCurrency.tr()
        : AppStrings.egpCurrency.tr();
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

  //login
  Future<void> setUserData(UserModel userModel) async {
    String encodedJson = json.encode(userModel.toJson());
    _sharedPreferences.setString(USER_MODEL, encodedJson);
  }

  UserModel? getUserData() {
    String? user = _sharedPreferences.getString(USER_MODEL);
    if (user != null) {
      Map<String, dynamic> decodedJson = json.decode(user);

      return UserModel.fromCachedJson(decodedJson);
    }
    return null;
  }

  setAuthToken(AuthModel authModel) {
    String encodedJson = json.encode(authModel.toJson());
    _sharedPreferences.setString(AUTH_TOKEN, encodedJson);
  }

  AuthModel? getAuthModel() {
    String? authModel = _sharedPreferences.getString(AUTH_TOKEN);
    if (authModel != null) {
      Map<String, dynamic> decodedJson = json.decode(authModel);

      return AuthModel.fromJson(decodedJson);
    }
    return null;
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getString(AUTH_TOKEN) != null;
  }

  Future<bool> refreshToken() async {
    AuthModel? authModel = getAuthModel();
    if (authModel != null) {
      LoginRepo loginRepo = instance();
      await loginRepo.refreshToken(authModel);
      return true;
    }
    return false;
  }

  //USER Firebase Token
  Future setFCMToken(String token) async {
    await _sharedPreferences.setString(USER_FCM_TOKEN, token);
  }

  Future<String?> getFCMToken() async {
    return _sharedPreferences.getString(USER_FCM_TOKEN);
  }

  Future removeFCMToken() async {
    await _sharedPreferences.remove(USER_FCM_TOKEN);
  }

  //USER Logout
  Future<void> logout(BuildContext context) async {
    // final LocalDataSource _localDataSource = instance<LocalDataSource>();
    await FirebaseAuth.instance.signOut();

    // clear cache of logged out user
    // _localDataSource.clearCache();
    _sharedPreferences.remove(USER_MODEL);
    _sharedPreferences.remove(AUTH_TOKEN);
    await removeFCMToken();

    Phoenix.rebirth(context);
  }
}
