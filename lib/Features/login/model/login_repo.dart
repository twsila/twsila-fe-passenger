import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:taxi_for_you/app/constants.dart';
import 'package:taxi_for_you/core/network/base_request_interface.dart';
import 'package:taxi_for_you/data/model/request-model.dart';

import '../../../core/network/http_base_request.dart';
import '../../../data/model/user-device.dart';

class LoginRepo {
  final BaseRequestInterface _baseRequest;

  LoginRepo(this._baseRequest);

  Future<dynamic> loginUser(String mobileNumber) async {
    UserDevice userDevice = await setUserDevice();
    var body = {'userDeviceDTO': userDevice.toJson(), "mobile": mobileNumber};
    RequestModel requestModel = RequestModel(
      endPoint: EndPointsConstants.login,
      reqBody: body,
      requestType: NETWORK_REQUEST_TYPE.POST,
    );

    try {
      dynamic response = await _baseRequest.sendRequest(requestModel);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserDevice> setUserDevice() async {
    late UserDevice userDevice;

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    if (Platform.isIOS) {
      userDevice = UserDevice(
        deviceOs: 'iPhone',
        appVersion: packageInfo.version,
        registrationId: '123',
      );
    } else {
      userDevice = UserDevice(
        deviceOs: 'Android',
        appVersion: packageInfo.version,
        registrationId: '123',
      );
    }

    return userDevice;
  }
}
