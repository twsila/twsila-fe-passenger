import 'package:taxi_for_you/app/constants.dart';
import 'package:taxi_for_you/core/network/base_request_interface.dart';
import 'package:taxi_for_you/data/model/request-model.dart';

import '../../../../core/network/http_base_request.dart';
import 'car-aid-model.dart';

class CarAidRepo {
  final BaseRequestInterface _baseRequest;

  CarAidRepo(this._baseRequest);

  Future<dynamic> sendCarAidRequest(CarAidModel carAidModel) async {
    Map<String, dynamic> body = carAidModel.toJson();
    RequestModel requestModel = RequestModel(
      endPoint: EndPointsConstants.sendCarAidRequest,
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
