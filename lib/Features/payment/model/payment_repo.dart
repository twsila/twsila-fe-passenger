import 'package:taxi_for_you/app/constants.dart';
import 'package:taxi_for_you/core/network/base_request_interface.dart';
import 'package:taxi_for_you/data/model/request-model.dart';

import '../../../../core/network/http_base_request.dart';

class PaymentRepo {
  final BaseRequestInterface _baseRequest;

  PaymentRepo(this._baseRequest);

  Future<dynamic> paymentRequest(String tripId) async {
    var body = {
      "tripId": tripId,
      "tripStatus": TripStatusConstants.waitForTakeOff,
    };
    RequestModel requestModel = RequestModel(
      endPoint: EndPointsConstants.changeStatus,
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
