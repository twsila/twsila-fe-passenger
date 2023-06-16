class CisternsModel {
  String? pickupLocationLongitude;
  String? pickupLocationLatitude;
  String? destinationLocationLongitude;
  String? destinationLocationLatitude;
  String? date;
  String? sourceLocationString;
  String? destinationLocationString;
  String? notes;
  String? cisternsType;
  int? paymentValue;

  CisternsModel();

  CisternsModel.fromJson(Map<String, dynamic> json) {
    pickupLocationLongitude = json['pickupLocationLongitude'];
    pickupLocationLatitude = json['pickupLocationLatitude'];
    destinationLocationLongitude = json['destinationLocationLongitude'];
    destinationLocationLatitude = json['destinationLocationLatitude'];
    date = json['date'];
    sourceLocationString = json['sourceLocationString'];
    sourceLocationString = json['destinationLocationString'];
    notes = json['notes'];
    cisternsType = json['cisternsType'];
    paymentValue = json['paymentValue'];
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
    if (cisternsType != null) data['cisternsType'] = cisternsType;
    if (paymentValue != null) data['paymentValue'] = paymentValue.toString();
    if (sourceLocationString != null) {
      data['sourceLocationString'] = sourceLocationString;
    }
    if (destinationLocationString != null) {
      data['destinationLocationString'] = destinationLocationString;
    }
    return data;
  }
}
