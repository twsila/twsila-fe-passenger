import 'package:taxi_for_you/app/app_prefs.dart';

import '../../../../../app/constants.dart';
import '../../../../../core/network/base_request_interface.dart';
import '../../../../../core/network/http_base_request.dart';
import '../../../../../data/model/request-model.dart';
import '../../../../../data/model/user-model.dart';
import '../../../../data/model/auth.dart';

class HomeRepo {
  final BaseRequestInterface _baseRequest;
  final AppPreferences appPreferences;

  HomeRepo(this._baseRequest, this.appPreferences);

  Future<dynamic> logoutUser() async {
    AuthModel? authModel = appPreferences.getAuthModel();

    var body = {'refreshToken': authModel?.refreshToken ?? ""};
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
