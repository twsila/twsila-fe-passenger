import 'dart:convert';

import 'package:flutter_image_compress/flutter_image_compress.dart';

class TransportationBaseModel {
  int? tripId;
  String? tripEndPoint;
  TransportationLocation pickupLocation = TransportationLocation();
  TransportationLocation destinationLocation = TransportationLocation();
  String? date;
  String? stringDate;
  String? notes;
  int? paymentValue;
  List<XFile>? images;

  TransportationBaseModel();

  fromJSON(Map<String, dynamic> json) {
    tripId = json['tripId'];
    tripEndPoint = json['tripEndPoint'];
    stringDate = json['date'];
    notes = json['notes'];
    paymentValue = int.parse(json['clientOffer']);
    pickupLocation =
        TransportationLocation.fromJson(jsonDecode(json['pickupLocation']));
    destinationLocation =
        TransportationLocation.fromJson(jsonDecode(json['destination']));
  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> data = <String, dynamic>{};
    if (date != null) data['date'] = stringDate;
    if (notes != null) data['notes'] = notes;
    data['clientOffer'] = paymentValue.toString();
    data['pickupLocation'] = json.encode(pickupLocation.toJson());
    data['destination'] = json.encode(destinationLocation.toJson());
    return data;
  }
}

class TransportationLocation {
  String? locationName;
  double? latitude;
  double? longitude;

  TransportationLocation();

  TransportationLocation.fromJson(Map<String, dynamic> json) {
    locationName = json['locationName'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};

    data['locationName'] = locationName;
    data['latitude'] = latitude;
    data['longitude'] = longitude;

    return data;
  }
}
