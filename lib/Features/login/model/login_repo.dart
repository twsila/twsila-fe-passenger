import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/constants.dart';
import 'package:taxi_for_you/app/global_variables.dart';
import 'package:taxi_for_you/core/network/base_request_interface.dart';
import 'package:taxi_for_you/data/model/auth.dart';
import 'package:taxi_for_you/data/model/request-model.dart';

import '../../../core/network/http_base_request.dart';
import '../../../data/model/user-device.dart';
import '../../../data/model/user-model.dart';

class LoginRepo {
  final BaseRequestInterface _baseRequest;
  final AppPreferences appPreferences;

  LoginRepo(
    this._baseRequest,
    this.appPreferences,
  );

  Future<dynamic> loginUser(String mobileNumber) async {
    UserDevice userDevice = await setUserDevice();
    var body = {
      'mobileUserDeviceDTO': userDevice.toJson(),
      "login": mobileNumber
    };
    RequestModel requestModel = RequestModel(
      endPoint: EndPointsConstants.login,
      reqBody: body,
      requestType: NETWORK_REQUEST_TYPE.POST,
    );

    try {
      dynamic response = await _baseRequest.sendRequest(requestModel);
      UserModel userModel = UserModel.fromJson(response.result);
      AuthModel authModel = AuthModel.fromJson(response.result);
      await appPreferences.setUserData(userModel);
      await appPreferences.setAuthToken(authModel);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> refreshToken(AuthModel authModel) async {
    var body = {
      'refreshToken': authModel.refreshToken,
    };
    RequestModel requestModel = RequestModel(
        endPoint: EndPointsConstants.refreshToken,
        reqBody: body,
        requestType: NETWORK_REQUEST_TYPE.POST,
        headers: {'Content-Type': 'application/json'});

    try {
      dynamic response = await _baseRequest.sendRequest(requestModel);
      if (response.result['success'] == false) {
        throw 'Something went wrong';
      }
      AuthModel auth = AuthModel(
          accesstoken: response.result['accessToken'],
          refreshToken: authModel.refreshToken);
      await appPreferences.setAuthToken(auth);
      return response;
    } catch (e) {
      appPreferences.logout(GlobalVariable.navigatorKey.currentContext!);
      rethrow;
    }
  }

  Future<UserDevice> setUserDevice() async {
    late UserDevice userDevice;

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String token = await appPreferences.getFCMToken() ?? '';

    if (Platform.isIOS) {
      userDevice = UserDevice(
        deviceOs: 'iPhone',
        appVersion: packageInfo.version,
        registrationId: token,
      );
    } else {
      userDevice = UserDevice(
        deviceOs: 'Android',
        appVersion: packageInfo.version,
        registrationId: token,
      );
    }

    return userDevice;
  }
}
