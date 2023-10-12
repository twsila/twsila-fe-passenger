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
  late Map<String, dynamic> jsonBody;

  void sendRequest(
      TransportationBaseModel transportationBaseModel, String tripStatus) {
    transportationBaseModel.tripStatus = tripStatus;
    var dynamicType = transportationBaseModel;
    if (dynamicType is PersonsModel) {
      jsonBody = dynamicType.toPersonsJson();
      return;
    } else if (dynamicType is FurnitureModel) {
      jsonBody = dynamicType.toFurnitureJson();
      return;
    } else if (dynamicType is GoodsModel) {
      jsonBody = dynamicType.toGoodsJson();
      return;
    } else if (dynamicType is WaterModel) {
      jsonBody = dynamicType.toWaterJson();
      return;
    } else if (dynamicType is CisternsModel) {
      jsonBody = dynamicType.toCisternsJson();
      return;
    } else if (dynamicType is CarAidModel) {
      jsonBody = dynamicType.toCarAidJson();
      return;
    } else if (dynamicType is FreezersModel) {
      jsonBody = dynamicType.toFreezersJson();
      return;
    }
    jsonBody = dynamicType.toJSON();
  }
}
