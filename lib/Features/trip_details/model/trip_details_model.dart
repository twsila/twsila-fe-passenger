import 'package:taxi_for_you/Features/transportation_requests/model/transportation_base_model.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/car_aid/models/car-aid-model.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/cisterns/models/cisterns_model.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/freezers/models/freezers-model.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/furniture/models/furniture_model.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/goods/models/goods_model.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/persons/model/persons_model.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/water_tank/models/water_model.dart';
import 'package:taxi_for_you/app/constants.dart';

class TripDetailsModel {
  final TransportationBaseModel tripDetails;

  TripDetailsModel({required this.tripDetails});

  factory TripDetailsModel.fromJson(Map<String, dynamic> json) {
    var details;
    String tripType = json['serviceType'];

    if (tripType == TripTypeConstants.furnitureType) {
      details = FurnitureModel.fromJson(json);
    } else if (tripType == TripTypeConstants.goodsType) {
      details = GoodsModel.fromJson(json);
    } else if (tripType == TripTypeConstants.frozenType) {
      details = FreezersModel.fromJson(json);
    } else if (tripType == TripTypeConstants.carAidType) {
      details = CarAidModel.fromJson(json);
    } else if (tripType == TripTypeConstants.drinkWaterType) {
      details = WaterModel.fromJson(json);
    } else if (tripType == TripTypeConstants.otherTankType) {
      details = CisternsModel.fromJson(json);
    } else if (tripType == TripTypeConstants.personType) {
      details = PersonsModel.fromJson(json);
    }

    return TripDetailsModel(tripDetails: details);
  }
}
