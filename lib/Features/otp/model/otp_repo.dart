import 'package:taxi_for_you/app/constants.dart';
import 'package:taxi_for_you/core/network/base_request_interface.dart';
import 'package:taxi_for_you/data/model/request-model.dart';

import '../../../core/network/http_base_request.dart';

class OtpRepo {
  final BaseRequestInterface _baseRequest;

  OtpRepo(this._baseRequest);

  Future<dynamic> generateOtp(String mobileNumber, String? appSignature) async {
    var body = {
      "mobile": mobileNumber,
      "appSignature": appSignature,
    };
    RequestModel requestModel = RequestModel(
      endPoint: EndPointsConstants.generateOtp,
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

  Future<dynamic> validateOtp(
      String otp, String generatedOtp, String mobileNumber) async {
    var body = {
      "userOtp": otp,
      "generatedOtp": generatedOtp,
      "mobile": mobileNumber
    };
    RequestModel requestModel = RequestModel(
      endPoint: EndPointsConstants.validateOtp,
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
