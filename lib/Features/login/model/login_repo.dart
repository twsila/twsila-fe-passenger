import 'package:taxi_for_you/app/constants.dart';
import 'package:taxi_for_you/core/network/base_request_interface.dart';
import 'package:taxi_for_you/data/model/request-model.dart';

import '../../../core/network/http_base_request.dart';
import '../../../data/model/user-device.dart';

class LoginRepo {
  final BaseRequestInterface _baseRequest;

  LoginRepo(this._baseRequest);

  Future<dynamic> loginUser(String mobileNumber) async {
    UserDevice userDevice = UserDevice(
        registrationId: "asda8sd84asd",
        appVersion: "android",
        deviceOs: "2.3,23");
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
}
