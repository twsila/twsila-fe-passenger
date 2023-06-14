import '../../../google_maps/model/location_model.dart';

class FreezersModel {
  String? pickupLocationLongitude;
  String? pickupLocationLatitude;
  String? destinationLocationLongitude;
  String? destinationLocationLatitude;
  String? date;
  String? sourceLocationString;
  String? destinationLocationString;
  String? notes;
  String? shippedType;
  String? frozenMaterial;
  int? paymentValue;
  int? goodsWeight;
  bool containsLoading = false;
  bool containscartons = false;

  FreezersModel();

  FreezersModel.fromJson(Map<String, dynamic> json) {
    pickupLocationLongitude = json['pickupLocationLongitude'];
    pickupLocationLatitude = json['pickupLocationLatitude'];
    destinationLocationLongitude = json['destinationLocationLongitude'];
    destinationLocationLatitude = json['destinationLocationLatitude'];
    date = json['date'];
    sourceLocationString = json['sourceLocationString'];
    sourceLocationString = json['destinationLocationString'];
    notes = json['notes'];
    shippedType = json['shippedType'];
    frozenMaterial = json['frozenMaterial'];
    containsLoading = json['containsLoading'];
    containscartons = json['containsLift'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    if (pickupLocationLongitude != null) {
      data['pickupLocationLongitude'] = pickupLocationLongitude;
    }
    if (pickupLocationLatitude != null) {
      data['pickupLocationLatitude'] = pickupLocationLatitude;
    }
    if (destinationLocationLongitude != null) {
      data['destinationLocationLongitude'] = destinationLocationLongitude;
    }
    if (destinationLocationLatitude != null) {
      data['destinationLocationLatitude'] = destinationLocationLatitude;
    }
    if (date != null) data['date'] = date;
    if (notes != null) data['notes'] = notes;
    if (shippedType != null) data['shippedType'] = shippedType;
    if (frozenMaterial != null) data['frozenMaterial'] = frozenMaterial;
    if (sourceLocationString != null) {
      data['sourceLocationString'] = sourceLocationString;
    }
    if (destinationLocationString != null) {
      data['destinationLocationString'] = destinationLocationString;
    }
    data['containsLoading'] = containsLoading.toString();
    data['containscartons'] = containscartons.toString();
    return data;
  }
}
