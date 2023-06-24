import 'package:flutter_image_compress/flutter_image_compress.dart';

class TransportationBaseModel {
  String? pickupLocationLongitude;
  String? pickupLocationLatitude;
  String? destinationLocationLongitude;
  String? destinationLocationLatitude;
  String? date;
  String? stringDate;
  String? pickupLocationName;
  String? destinationLocationName;
  String? notes;
  int? paymentValue;
  List<XFile>? images;

  TransportationBaseModel();

  fromJSON(Map<String, dynamic> json) {
    pickupLocationLongitude = json['pickupLocationLongitude'];
    pickupLocationLatitude = json['pickupLocationLatitude'];
    destinationLocationLongitude = json['destinationLocationLongitude'];
    destinationLocationLatitude = json['destinationLocationLatitude'];
    stringDate = json['date'];
    pickupLocationName = json['pickupLocationName'];
    pickupLocationName = json['destinationLocationName'];
    notes = json['notes'];
    paymentValue = json['clientOffer'];
  }

  Map<String, dynamic> toJSON() {
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
    if (pickupLocationName != null) {
      data['pickupLocationName'] = pickupLocationName;
    }
    if (destinationLocationName != null) {
      data['destinationLocationName'] = destinationLocationName;
    }
    data['clientOffer'] = paymentValue.toString();
    return data;
  }
}
