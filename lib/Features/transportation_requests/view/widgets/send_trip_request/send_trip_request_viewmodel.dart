import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/persons/model/persons_model.dart';

import '../../../../../../app/constants.dart';
import '../../../model/transportation_base_model.dart';
import '../transportation_widgets/car_aid/models/car-aid-model.dart';
import '../transportation_widgets/cisterns/models/cisterns_model.dart';
import '../transportation_widgets/freezers/models/freezers-model.dart';
import '../transportation_widgets/furniture/models/furniture_model.dart';
import '../transportation_widgets/goods/models/goods_model.dart';
import '../transportation_widgets/water_tank/models/water_model.dart';

class SendTripRequestViewModel {
  late String endPoint;
  late Map<String, dynamic> jsonBody;

  void sendRequest(
      TransportationBaseModel transportationBaseModel, String tripStatus) {
    transportationBaseModel.tripStatus = tripStatus;
    var dynamicType = transportationBaseModel;
    if (dynamicType is PersonsModel) {
      endPoint = EndPointsConstants.sendPersonRequest;
      jsonBody = dynamicType.toPersonsJson();
      return;
    } else if (dynamicType is FurnitureModel) {
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
