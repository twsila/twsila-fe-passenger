import 'package:taxi_for_you/app/app_prefs.dart';

import '../../../../../app/constants.dart';
import '../../../../../core/network/base_request_interface.dart';
import '../../../../../core/network/http_base_request.dart';
import '../../../../../data/model/request-model.dart';
import '../../../../../data/model/user-model.dart';

class HomeRepo {
  final BaseRequestInterface _baseRequest;
  final AppPreferences appPreferences;

  HomeRepo(this._baseRequest, this.appPreferences);

  Future<dynamic> logoutUser() async {
    UserModel? userModel = appPreferences.getUserData();
    String token = await appPreferences.getFCMToken() ?? '';

    var body = {'userId': userModel!.userid, "registrationId": token};
    RequestModel requestModel = RequestModel(
      endPoint: EndPointsConstants.logout,
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
