// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_for_you/Features/transportation_requests/model/transportation_base_model.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/car_aid/models/car-aid-model.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/cisterns/models/cisterns_model.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/freezers/models/freezers-model.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/furniture/models/furniture_model.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/goods/models/goods_model.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/water_tank/models/water_model.dart';
import 'package:taxi_for_you/app/constants.dart';
import 'package:taxi_for_you/core/utils/resources/assets_manager.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';
import 'package:taxi_for_you/data/model/country.dart';
import 'package:taxi_for_you/data/model/user-model.dart';
import '../core/utils/resources/langauge_manager.dart';

const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
const String USER_MODEL = "USER_MODEL";
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
    removeTrips();
    _sharedPreferences.remove(USER_MODEL);

    Phoenix.rebirth(context);
  }

  //Save Trip to cache
  Future saveTripToCache({
    required Map<String, dynamic> tripJson,
    required String tripType,
  }) async {
    if (tripType == TripTypeConstants.furnitureType) {
      await _sharedPreferences.setString(FURNITURE_TRIP, json.encode(tripJson));
    } else if (tripType == TripTypeConstants.goodsType) {
      await _sharedPreferences.setString(GOODS_TRIP, json.encode(tripJson));
    } else if (tripType == TripTypeConstants.carAidType) {
      await _sharedPreferences.setString(CAR_AID_TRIP, json.encode(tripJson));
    } else if (tripType == TripTypeConstants.frozenType) {
      await _sharedPreferences.setString(FREEZERS_TRIP, json.encode(tripJson));
    } else if (tripType == TripTypeConstants.otherTankType) {
      await _sharedPreferences.setString(CISTERNS_TRIP, json.encode(tripJson));
    } else if (tripType == TripTypeConstants.drinkWaterType) {
      await _sharedPreferences.setString(WATER_TRIP, json.encode(tripJson));
    } else if (tripType == TripTypeConstants.personType) {
      await _sharedPreferences.setString(PERSON_TRIP, json.encode(tripJson));
    }
  }

  List<TransportationBaseModel> getTrips() {
    List<TransportationBaseModel> tripList = [];
    if (_sharedPreferences.getString(FURNITURE_TRIP) != null) {
      tripList.add(FurnitureModel.fromJson(
        json.decode(_sharedPreferences.getString(FURNITURE_TRIP)!),
      ));
    }
    if (_sharedPreferences.getString(GOODS_TRIP) != null) {
      tripList.add(GoodsModel.fromJson(
        json.decode(_sharedPreferences.getString(GOODS_TRIP)!),
      ));
    }
    if (_sharedPreferences.getString(FREEZERS_TRIP) != null) {
      tripList.add(FreezersModel.fromJson(
        json.decode(_sharedPreferences.getString(FREEZERS_TRIP)!),
      ));
    }
    if (_sharedPreferences.getString(CAR_AID_TRIP) != null) {
      tripList.add(CarAidModel.fromJson(
        json.decode(_sharedPreferences.getString(CAR_AID_TRIP)!),
      ));
    }
    if (_sharedPreferences.getString(CISTERNS_TRIP) != null) {
      tripList.add(CisternsModel.fromJson(
        json.decode(_sharedPreferences.getString(CISTERNS_TRIP)!),
      ));
    }
    if (_sharedPreferences.getString(WATER_TRIP) != null) {
      tripList.add(WaterModel.fromJson(
        json.decode(_sharedPreferences.getString(WATER_TRIP)!),
      ));
    }
    return tripList;
  }

  void removeTrips() {
    _sharedPreferences.remove(FURNITURE_TRIP);
    _sharedPreferences.remove(GOODS_TRIP);
    _sharedPreferences.remove(CAR_AID_TRIP);
    _sharedPreferences.remove(WATER_TRIP);
    _sharedPreferences.remove(CISTERNS_TRIP);
    _sharedPreferences.remove(FREEZERS_TRIP);
    _sharedPreferences.remove(PERSON_TRIP);
  }

  void removeTripByType(String tripType) {
    if (tripType == TripTypeConstants.furnitureType) {
      _sharedPreferences.remove(FURNITURE_TRIP);
    } else if (tripType == TripTypeConstants.goodsType) {
      _sharedPreferences.remove(GOODS_TRIP);
    } else if (tripType == TripTypeConstants.carAidType) {
      _sharedPreferences.remove(CAR_AID_TRIP);
    } else if (tripType == TripTypeConstants.frozenType) {
      _sharedPreferences.remove(FREEZERS_TRIP);
    } else if (tripType == TripTypeConstants.otherTankType) {
      _sharedPreferences.remove(CISTERNS_TRIP);
    } else if (tripType == TripTypeConstants.drinkWaterType) {
      _sharedPreferences.remove(WATER_TRIP);
    } else if (tripType == TripTypeConstants.personType) {
      _sharedPreferences.remove(PERSON_TRIP);
    }
  }
}
