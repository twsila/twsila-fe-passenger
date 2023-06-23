class CisternsModel {
  String? pickupLocationLongitude;
  String? pickupLocationLatitude;
  String? destinationLocationLongitude;
  String? destinationLocationLatitude;
  String? date;
  String? stringDate;
  String? pickupLocationName;
  String? destinationLocationName;
  String? notes;
  String? cisternsType;
  int? paymentValue;

  CisternsModel();

  CisternsModel.fromJson(Map<String, dynamic> json) {
    pickupLocationLongitude = json['pickupLocationLongitude'];
    pickupLocationLatitude = json['pickupLocationLatitude'];
    destinationLocationLongitude = json['destinationLocationLongitude'];
    destinationLocationLatitude = json['destinationLocationLatitude'];
    stringDate = json['date'];
    pickupLocationName = json['pickupLocationName'];
    pickupLocationName = json['destinationLocationName'];
    notes = json['notes'];
    cisternsType = json['cisternsType'];
    paymentValue = json['clientOffer'];
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
    if (cisternsType != null) data['tankType'] = 'SEWER'; //TODO: TO BE FIXED
    if (paymentValue != null) data['clientOffer'] = paymentValue.toString();
    if (pickupLocationName != null) {
      data['pickupLocationName'] = pickupLocationName;
    }
    if (destinationLocationName != null) {
      data['destinationLocationName'] = destinationLocationName;
    }
    return data;
  }
}
