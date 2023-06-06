// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_for_you/core/utils/resources/assets_manager.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';
import 'package:taxi_for_you/data/model/country.dart';
import 'package:taxi_for_you/data/model/user-model.dart';
import '../core/utils/resources/langauge_manager.dart';

const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
const String USER_MODEL = "USER_MODEL";
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

  List<CountryModel> getCountries() {
    List<CountryModel> countries = [
      CountryModel(
        countryID: '1',
        countryName: AppStrings.saudi.tr(),
        country: "SA",
        countryCode: "+966",
        imageURL: ImageAssets.saudiFlag,
      ),
      CountryModel(
        countryID: '2',
        countryName: AppStrings.egypt.tr(),
        country: "EG",
        countryCode: "+20",
        imageURL: ImageAssets.egyptFlag,
      ),
    ];
    return countries;
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
  setUserSelectedCountry(CountryModel country) {
    _sharedPreferences.setString(USER_SELECTED_COUNTRY, json.encode(country));
  }

  CountryModel? getUserSelectedCountry() {
    try {
      var country = _sharedPreferences.getString(USER_SELECTED_COUNTRY);
      if (country != null) {
        var countryModel = CountryModel.fromJson(const JsonDecoder().convert(
            _sharedPreferences.getString(USER_SELECTED_COUNTRY) ?? ''));
        return countryModel;
      }
      return null;
    } catch (error) {
      return null;
    }
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
  Future<void> setUserLoggedIn(UserModel userModel) async {
    String encodedJson = json.encode(userModel.toJson());
    _sharedPreferences.setString(USER_MODEL, encodedJson);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getString(USER_MODEL) != null;
  }

  UserModel? getUserData() {
    String? user = _sharedPreferences.getString(USER_MODEL);
    if (user != null) {
      Map<String, dynamic> decodedJson = json.decode(user);

      return UserModel.fromJson(decodedJson);
    }
    return null;
  }

  Future<void> logout(BuildContext context) async {
    // final LocalDataSource _localDataSource = instance<LocalDataSource>();
    await FirebaseAuth.instance.signOut();

    // clear cache of logged out user
    // _localDataSource.clearCache();

    _sharedPreferences.remove(USER_MODEL);

    Phoenix.rebirth(context);
  }
}
