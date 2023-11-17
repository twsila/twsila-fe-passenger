// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_for_you/Features/login/model/login_repo.dart';
import 'package:taxi_for_you/Features/lookups/model/lookups_model.dart';
import 'package:taxi_for_you/Features/lookups/model/models/vehicle_type.dart';
import 'package:taxi_for_you/app/constants.dart';
import 'package:taxi_for_you/app/di.dart';
import 'package:taxi_for_you/core/utils/resources/assets_manager.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';
import 'package:taxi_for_you/data/model/country.dart';
import 'package:taxi_for_you/data/model/user-model.dart';
import '../core/utils/resources/langauge_manager.dart';
import 'package:collection/collection.dart';

const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
const String USER_MODEL = "USER_MODEL";
const String USER_FCM_TOKEN = "USER_FCM_TOKEN";
const String USER_SELECTED_COUNTRY = "USER_SELECTED_COUNTRY";
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
  List<CountryModel> countries = [];

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

  LookupsModel getLookupsInstance() {
    return instance.get<LookupsModel>(instanceName: GetItInstanceNames.lookups);
  }

  VehicleTypes getVehicleInstance() {
    return instance.get<VehicleTypes>(
        instanceName: GetItInstanceNames.vehicleTypes);
  }

  setCountries(List<CountryModel> countries) {
    this.countries = countries;
  }

  List<CountryModel> getCountries() {
    return countries.isNotEmpty
        ? countries
        : [
            CountryModel(
              countryID: 2,
              countryName: AppStrings.saudi.tr(),
              country: "SA",
              countryCode: "+966",
              imageURL: ImageAssets.saudiFlag,
            ),
            CountryModel(
              countryID: 4,
              countryName: AppStrings.egypt.tr(),
              country: "EG",
              countryCode: "+20",
              imageURL: ImageAssets.egyptFlag,
            ),
          ];
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
  setUserSelectedCountry(CountryModel? country) {
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
      UserModel? user = getUserData();
      if (user != null) {
        if (user.mobileNumber!.contains('+20')) {
          CountryModel? country = getCountries().singleWhereOrNull(
            (element) => element.countryCode == '+20',
          );
          return country;
        } else if (user.mobileNumber!.contains('+966')) {
          CountryModel? country = getCountries().singleWhereOrNull(
            (element) => element.countryCode == '+966',
          );
          return country;
        }
      }
      return null;
    } catch (error) {
      return null;
    }
  }

  String getCurrentCurrnecy() {
    if (getUserSelectedCountry() == null) {
      UserModel? user = getUserData();
      if (user != null) {
        if (user.mobileNumber!.contains('+20')) {
          return AppStrings.egpCurrency.tr();
        } else if (user.mobileNumber!.contains('+966')) {
          return AppStrings.saudiCurrency.tr();
        }
      }
      return AppStrings.saudiCurrency.tr();
    }
    return getUserSelectedCountry()!.country == "SA"
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
  Future<void> setUserLoggedIn(UserModel userModel) async {
    String encodedJson = json.encode(userModel.toJson(true));
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

  Future<bool> refreshToken() async {
    String? user = _sharedPreferences.getString(USER_MODEL);
    if (user != null) {
      Map<String, dynamic> decodedJson = json.decode(user);

      UserModel userModel = UserModel.fromJson(decodedJson);
      LoginRepo loginRepo = instance();
      await loginRepo.loginUser(userModel.mobileNumber!);
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
    await removeFCMToken();

    Phoenix.rebirth(context);
  }

  List<LookupItem> getLookupByKey(String key) {
    LookupsModel lookupsModel =
        instance.get(instanceName: GetItInstanceNames.lookups);
    LookupModel lookup = lookupsModel.lookupModel.singleWhere((element) =>
        element.lookupKey == key && getAppLanguage() == element.language);

    return lookup.lookupJson;
  }

  LookupItem getLookupIndex(String key, String value) {
    LookupsModel lookupsModel =
        instance.get(instanceName: GetItInstanceNames.lookups);

    LookupModel lookupEnglish = lookupsModel.lookupModel.singleWhere(
        (element) =>
            element.lookupKey == key &&
            LanguageType.ENGLISH.getValue() == element.language);

    LookupModel lookupArabic = lookupsModel.lookupModel.singleWhere((element) =>
        element.lookupKey == key &&
        LanguageType.ARABIC.getValue() == element.language);

    int index = lookupEnglish.lookupJson
        .indexWhere((element) => element.value == value);

    if (isEnglish()) return lookupEnglish.lookupJson[index];

    return lookupArabic.lookupJson[index];
  }
}
