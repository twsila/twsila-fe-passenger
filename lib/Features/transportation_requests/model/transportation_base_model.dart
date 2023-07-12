import 'dart:convert';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:taxi_for_you/core/utils/helpers/double_prase.dart';

class TransportationBaseModel {
  int? tripId;
  String? tripEndPoint;
  String? tripType;
  TransportationLocation pickupLocation = TransportationLocation();
  TransportationLocation destinationLocation = TransportationLocation();
  String? creationDate;
  String? date;
  String? stringDate;
  String? notes;
  double? paymentValue;
  List<XFile>? images;

  TransportationBaseModel();

  fromJSON(Map<String, dynamic> json) {
    tripId = json['id'];
    tripEndPoint = json['tripEndPoint'];
    tripType = json['tripType'];
    creationDate = json['creationDate'];
    stringDate = json['date'];
    date = json['stringDate'];
    notes = json['notes'];
    paymentValue = (json['clientOffer'] != null)
        ? dynamicToDouble(json['clientOffer'])
        : null;
    pickupLocation = TransportationLocation.fromJson(
        json['pickupLocation'] is String
            ? jsonDecode(json['pickupLocation'])
            : json['pickupLocation']);
    destinationLocation = TransportationLocation.fromJson(
        json['destination'] is String
            ? jsonDecode(json['destination'])
            : json['destination']);
    return this;
  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> data = <String, dynamic>{};
    if (creationDate != null) data['creationDate'] = creationDate;
    if (stringDate != null) data['date'] = stringDate;
    if (date != null) data['stringDate'] = date;
    if (notes != null) data['notes'] = notes;
    if (paymentValue != null) data['clientOffer'] = paymentValue.toString();
    data['pickupLocation'] = json.encode(pickupLocation.toJson());
    data['destination'] = json.encode(destinationLocation.toJson());
    data['tripType'] = tripType;
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

  TransportationLocation copyWith(TransportationLocation location) {
    TransportationLocation transportationLocation = TransportationLocation();

    transportationLocation.locationName = location.locationName;
    transportationLocation.longitude = location.longitude;
    transportationLocation.latitude = location.latitude;

    return transportationLocation;
  }
}
