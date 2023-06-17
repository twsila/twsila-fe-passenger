import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:taxi_for_you/core/network/base_request_interface.dart';
import 'package:taxi_for_you/data/model/request-model.dart';

import '../../../../core/network/http_base_request.dart';

class TransportationRepo {
  final BaseRequestInterface _baseRequest;

  TransportationRepo(this._baseRequest);

  Future<dynamic> sendTransportationRequest(
    String endPoint,
    List<XFile>? files,
    Map<String, dynamic> body,
  ) async {
    RequestModel requestModel = RequestModel(
      endPoint: endPoint,
      reqBody: body,
      requestType: NETWORK_REQUEST_TYPE.POST,
    );
    try {
      dynamic response =
          await _baseRequest.sendMultiPartRequest(requestModel, files, body);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
