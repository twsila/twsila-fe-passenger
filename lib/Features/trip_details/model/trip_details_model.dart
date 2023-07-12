import 'package:taxi_for_you/Features/transportation_requests/model/transportation_base_model.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/car_aid/models/car-aid-model.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/cisterns/models/cisterns_model.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/freezers/models/freezers-model.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/furniture/models/furniture_model.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/goods/models/goods_model.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/water_tank/models/water_model.dart';
import 'package:taxi_for_you/Features/trip_details/model/offer_model.dart';
import 'package:taxi_for_you/app/constants.dart';

class TripDetailsModel {
  final TransportationBaseModel tripDetails;
  final OfferModel? offer;

  TripDetailsModel({required this.tripDetails, required this.offer});

  factory TripDetailsModel.fromJson(Map<String, dynamic> json) {
    var details;
    Map<String, dynamic> tripJson = json['trip'];
    String tripType = tripJson['tripType'];

    if (tripType == TripTypeConstants.furnitureType) {
      details = FurnitureModel.fromJson(tripJson);
    } else if (tripType == TripTypeConstants.goodsType) {
      details = GoodsModel.fromJson(tripJson);
    } else if (tripType == TripTypeConstants.frozenType) {
      details = FreezersModel.fromJson(tripJson);
    } else if (tripType == TripTypeConstants.carAidType) {
      details = CarAidModel.fromJson(tripJson);
    } else if (tripType == TripTypeConstants.drinkWaterType) {
      details = WaterModel.fromJson(tripJson);
    } else if (tripType == TripTypeConstants.otherTankType) {
      details = CisternsModel.fromJson(tripJson);
    } else if (tripType == TripTypeConstants.personType) {
      details = CisternsModel.fromJson(tripJson);
    }

    return TripDetailsModel(tripDetails: details, offer: null);
  }
}
