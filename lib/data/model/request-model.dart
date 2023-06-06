import '../../core/network/http_base_request.dart';

class RequestModel {
  final String endPoint;
  final Map<String, dynamic> reqBody;
  final NETWORK_REQUEST_TYPE requestType;

  RequestModel({
    required this.endPoint,
    required this.reqBody,
    required this.requestType,
  });
}
