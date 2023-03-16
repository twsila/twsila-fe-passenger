import '../../presentation/google_maps/model/location_model.dart';

class FreezersModel {
  LocationModel? sourceLocation;
  LocationModel? destinationLocation;
  String? date;
  String? sourceLocationString;
  String? destinationLocationString;
  String? notes;
  String? shippedType;
  String? shippedMaterial;
  int? paymentValue;
  int? goodsWeight;
  bool loadingBool = false;
  bool cartonsBool = false;
}
