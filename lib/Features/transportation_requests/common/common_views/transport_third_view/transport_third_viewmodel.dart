import 'package:taxi_for_you/Features/transportation_requests/car_aid_view/models/car-aid-model.dart';
import 'package:taxi_for_you/Features/transportation_requests/cisterns_view/models/cisterns_model.dart';
import 'package:taxi_for_you/Features/transportation_requests/common/common_repo/transportation_base_model.dart';
import 'package:taxi_for_you/Features/transportation_requests/freezers_view/models/freezers-model.dart';
import 'package:taxi_for_you/Features/transportation_requests/water_tank_view/models/water_model.dart';

import '../../../../../app/constants.dart';
import '../../../furniture_view/models/furniture_model.dart';
import '../../../goods_view/models/goods_model.dart';

class TransportThirdViewModel {
  late String endPoint;
  late Map<String, dynamic> jsonBody;

  void sendRequest(TransportationBaseModel transportationBaseModel) {
    var dynamicType = transportationBaseModel;
    if (dynamicType is FurnitureModel) {
      endPoint = EndPointsConstants.sendFurnitureRequest;
      jsonBody = dynamicType.toFurnitureJson();
      return;
    } else if (dynamicType is GoodsModel) {
      endPoint = EndPointsConstants.sendGoodsRequest;
      jsonBody = dynamicType.toGoodsJson();
      return;
    } else if (dynamicType is WaterModel) {
      endPoint = EndPointsConstants.sendWaterRequest;
      jsonBody = dynamicType.toWaterJson();
      return;
    } else if (dynamicType is CisternsModel) {
      endPoint = EndPointsConstants.sendCisternsRequest;
      jsonBody = dynamicType.toCisternsJson();
      return;
    } else if (dynamicType is CarAidModel) {
      endPoint = EndPointsConstants.sendCarAidRequest;
      jsonBody = dynamicType.toCarAidJson();
      return;
    } else if (dynamicType is FreezersModel) {
      endPoint = EndPointsConstants.sendFreezersRequest;
      jsonBody = dynamicType.toFreezersJson();
      return;
    }
    endPoint = EndPointsConstants.sendFurnitureRequest;
    jsonBody = dynamicType.toJSON();
  }
}
