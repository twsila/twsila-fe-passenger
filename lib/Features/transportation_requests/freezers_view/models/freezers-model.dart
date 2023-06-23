class FreezersModel {
  String? pickupLocationLongitude;
  String? pickupLocationLatitude;
  String? destinationLocationLongitude;
  String? destinationLocationLatitude;
  String? date;
  String? stringDate;
  String? pickupLocationName;
  String? destinationLocationName;
  String? notes;
  String? shippedType;
  String? frozenMaterial;
  int? paymentValue;
  int? goodsWeight;
  bool containsLoading = false;
  bool containsPacking = false;
  bool containsLift = false;

  FreezersModel();

  FreezersModel.fromJson(Map<String, dynamic> json) {
    pickupLocationLongitude = json['pickupLocationLongitude'];
    pickupLocationLatitude = json['pickupLocationLatitude'];
    destinationLocationLongitude = json['destinationLocationLongitude'];
    destinationLocationLatitude = json['destinationLocationLatitude'];
    stringDate = json['date'];
    pickupLocationName = json['pickupLocationName'];
    destinationLocationName = json['destinationLocationName'];
    notes = json['notes'];
    paymentValue = json['clientOffer'];
    shippedType = json['shippingType'];
    frozenMaterial = json['frozenMaterial'];
    containsLoading = json['containsLoading'];
    containsPacking = json['containsPacking'];
    containsPacking = json['containsLift'];
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
    if (date != null) data['date'] = stringDate;
    if (notes != null) data['notes'] = notes;
    if (shippedType != null) data['shippingType'] = 'DRY'; //TODO: TO BE FIXED
    if (frozenMaterial != null) data['frozenMaterial'] = frozenMaterial;
    if (pickupLocationName != null) {
      data['pickupLocationName'] = pickupLocationName;
    }
    if (destinationLocationName != null) {
      data['destinationLocationName'] = destinationLocationName;
    }
    data['clientOffer'] = paymentValue.toString();
    data['containsLoading'] = containsLoading.toString();
    data['containsPacking'] = containsPacking.toString();
    data['containsLift'] = containsLift.toString();
    return data;
  }
}
