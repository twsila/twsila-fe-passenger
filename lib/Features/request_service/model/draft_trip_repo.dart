import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/constants.dart';
import 'package:taxi_for_you/app/di.dart';
import 'package:taxi_for_you/core/network/base_request_interface.dart';
import 'package:taxi_for_you/data/model/request-model.dart';

import '../../../../core/network/http_base_request.dart';
import '../../../../data/model/user-model.dart';

class DraftTripRepo {
  final BaseRequestInterface _baseRequest;

  DraftTripRepo(this._baseRequest);

  Future<dynamic> getDraftTrip() async {
    Map<String, dynamic> body = {};
    UserModel? userModel = getUserData();
    body['userId'] = userModel!.userid;

    RequestModel requestModel = RequestModel(
      endPoint: EndPointsConstants.getDraftTrip,
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

  UserModel? getUserData() {
    AppPreferences appPreferences = instance<AppPreferences>();
    UserModel? userModel = appPreferences.getUserData();
    return userModel;
  }
}
