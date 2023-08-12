import 'package:taxi_for_you/app/constants.dart';
import 'package:taxi_for_you/core/network/base_request_interface.dart';
import 'package:taxi_for_you/data/model/request-model.dart';
import 'package:taxi_for_you/data/model/user-model.dart';

import '../../../core/network/http_base_request.dart';

class RegistrationRepo {
  final BaseRequestInterface _baseRequest;

  RegistrationRepo(this._baseRequest);

  Future<dynamic> registrationUser(UserModel userModel) async {
    RequestModel requestModel = RequestModel(
      endPoint: EndPointsConstants.register,
      reqBody: userModel.toJson(false),
      requestType: NETWORK_REQUEST_TYPE.POST,
    );

    try {
      dynamic response = await _baseRequest.sendRequest(requestModel);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> editUser(UserModel userModel) async {
    RequestModel requestModel = RequestModel(
      endPoint: EndPointsConstants.editProfile,
      reqBody: userModel.toJson(false),
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
