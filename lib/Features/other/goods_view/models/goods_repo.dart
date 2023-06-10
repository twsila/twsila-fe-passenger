import 'package:taxi_for_you/app/constants.dart';
import 'package:taxi_for_you/core/network/base_request_interface.dart';
import 'package:taxi_for_you/data/model/request-model.dart';

import '../../../../core/network/http_base_request.dart';
import '../../goods_view/models/goods_model.dart';

class GoodsRepo {
  final BaseRequestInterface _baseRequest;

  GoodsRepo(this._baseRequest);

  Future<dynamic> sendGoodsRequest(GoodsModel goodsModel) async {
    Map<String, dynamic> body = goodsModel.toJson();
    RequestModel requestModel = RequestModel(
      endPoint: EndPointsConstants.sendGoodsRequest,
      reqBody: body,
      requestType: NETWORK_REQUEST_TYPE.POST,
    );
    try {
      dynamic response = await _baseRequest.sendMultiPartRequest(
          requestModel, goodsModel.images, body);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
