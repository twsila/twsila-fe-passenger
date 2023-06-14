import 'package:taxi_for_you/app/constants.dart';
import 'package:taxi_for_you/core/network/base_request_interface.dart';
import 'package:taxi_for_you/data/model/request-model.dart';

import '../../../../core/network/http_base_request.dart';
import 'freezers-model.dart';

class FreezersRepo {
  final BaseRequestInterface _baseRequest;

  FreezersRepo(this._baseRequest);

  Future<dynamic> sendFreezersRequest(FreezersModel freezersModel) async {
    Map<String, dynamic> body = freezersModel.toJson();
    RequestModel requestModel = RequestModel(
      endPoint: EndPointsConstants.sendFreezersRequest,
      reqBody: body,
      requestType: NETWORK_REQUEST_TYPE.POST,
    );
    try {
      dynamic response =
          await _baseRequest.sendMultiPartRequest(requestModel, null, body);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
