import 'package:taxi_for_you/app/constants.dart';

import '../../core/network/http_base_request.dart';

class RequestModel {
  final String endPoint;
  final Map<String, dynamic> reqBody;
  final Map<String, String> headers;
  final NETWORK_REQUEST_TYPE requestType;

  RequestModel({
    required this.endPoint,
    required this.reqBody,
    required this.requestType,
    this.headers = Constants.headers,
  });
}
