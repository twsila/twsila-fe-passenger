import 'dart:developer';

import 'package:taxi_for_you/Features/other/furniture_view/models/furniture_model.dart';
import 'package:taxi_for_you/app/constants.dart';
import 'package:taxi_for_you/core/network/base_request_interface.dart';
import 'package:taxi_for_you/data/model/request-model.dart';

import '../../../../core/network/http_base_request.dart';

class FurnitureRepo {
  final BaseRequestInterface _baseRequest;

  FurnitureRepo(this._baseRequest);

  Future<dynamic> sendFurnitureRequest(FurnitureModel furnitureModel) async {
    Map<String, dynamic> body = furnitureModel.toJson();
    RequestModel requestModel = RequestModel(
      endPoint: EndPointsConstants.sendFurnitureRequest,
      reqBody: body,
      requestType: NETWORK_REQUEST_TYPE.POST,
    );
    try {
      dynamic response = await _baseRequest.sendMultiPartRequest(
          requestModel, furnitureModel.images, body);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
