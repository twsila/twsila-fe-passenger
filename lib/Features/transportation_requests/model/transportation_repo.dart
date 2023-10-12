import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/constants.dart';
import 'package:taxi_for_you/app/di.dart';
import 'package:taxi_for_you/core/network/base_request_interface.dart';
import 'package:taxi_for_you/data/model/request-model.dart';

import '../../../../core/network/http_base_request.dart';
import '../../../../data/model/user-model.dart';

class TransportationRepo {
  final BaseRequestInterface _baseRequest;

  TransportationRepo(this._baseRequest);

  Future<dynamic> sendTransportationRequest(
    List<XFile>? files,
    Map<String, dynamic> body,
  ) async {
    RequestModel requestModel = RequestModel(
      endPoint: EndPointsConstants.sendTripRequest,
      reqBody: body,
      requestType: NETWORK_REQUEST_TYPE.POST,
    );
    try {
      UserModel? userModel = getUserData();
      body['Passenger.passengerId'] = userModel!.userid.toString();
      dynamic response =
          await _baseRequest.sendMultiPartRequest(requestModel, files, body);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  UserModel? getUserData() {
    AppPreferences appPreferences = instance<AppPreferences>();
    UserModel? userModel = appPreferences.getUserData();
    return userModel;
  }
}
