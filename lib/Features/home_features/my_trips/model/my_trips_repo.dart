import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/constants.dart';
import 'package:taxi_for_you/app/di.dart';
import 'package:taxi_for_you/core/network/base_request_interface.dart';
import 'package:taxi_for_you/data/model/request-model.dart';

import '../../../../../core/network/http_base_request.dart';
import '../../../../../data/model/user-model.dart';

class MyTripsRepo {
  final BaseRequestInterface _baseRequest;

  MyTripsRepo(this._baseRequest);

  Future<dynamic> getUserTripsRequest(
    int tripModelType,
  ) async {
    try {
      UserModel? userModel = getUserData();
      Map<String, dynamic> body = {
        'tripModelType': tripModelType,
        'userId': userModel!.userid.toString()
      };

      RequestModel requestModel = RequestModel(
        endPoint: EndPointsConstants.userTrips,
        reqBody: body,
        requestType: NETWORK_REQUEST_TYPE.POST,
      );
      dynamic response = await _baseRequest.sendRequest(requestModel);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> cancelTripRequest(
    int tripId,
  ) async {
    try {
      Map<String, dynamic> body = {
        'tripId': tripId,
      };

      RequestModel requestModel = RequestModel(
        endPoint: EndPointsConstants.cancelTrip,
        reqBody: body,
        requestType: NETWORK_REQUEST_TYPE.POST,
      );
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
