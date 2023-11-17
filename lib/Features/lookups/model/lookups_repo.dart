import 'package:taxi_for_you/app/constants.dart';
import 'package:taxi_for_you/core/network/base_request_interface.dart';
import 'package:taxi_for_you/data/model/request-model.dart';

import '../../../../core/network/http_base_request.dart';

class LookupsRepo {
  final BaseRequestInterface _baseRequest;

  LookupsRepo(this._baseRequest);

  Future<dynamic> getLookups() async {
    try {
      RequestModel requestModel = RequestModel(
        endPoint: EndPointsConstants.lookups,
        reqBody: {},
        requestType: NETWORK_REQUEST_TYPE.GET,
      );
      dynamic response = await _baseRequest.sendRequest(requestModel);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getLookupsByKey(String key) async {
    try {
      RequestModel requestModel = RequestModel(
        endPoint: EndPointsConstants.lookupsByKey,
        reqBody: {"lookupKey": key},
        requestType: NETWORK_REQUEST_TYPE.POST,
      );
      dynamic response = await _baseRequest.sendRequest(requestModel);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getCountriesLookups() async {
    try {
      RequestModel requestModel = RequestModel(
        endPoint: EndPointsConstants.lookupCountries,
        reqBody: {},
        requestType: NETWORK_REQUEST_TYPE.GET,
      );
      dynamic response = await _baseRequest.sendRequest(requestModel);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
