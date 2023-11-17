import 'dart:convert';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:taxi_for_you/Features/trip_details/model/offer_model.dart';
import 'package:taxi_for_you/core/utils/helpers/double_prase.dart';

class TransportationBaseModel {
  int? tripId;
  String? tripEndPoint;
  String? tripType;
  String? tripNumber;
  String? tripStatus;
  TransportationLocation pickupLocation = TransportationLocation();
  TransportationLocation destinationLocation = TransportationLocation();
  String? creationDate;
  String? date;
  String? stringDate;
  String? notes;
  String? cancelledBy;
  double? paymentValue;
  List<XFile>? images;
  AcceptedOffer? acceptedOffer;
  List<OfferModel>? offers;

  TransportationBaseModel();

  fromJSON(Map<String, dynamic> json) {
    tripId = json['id'] is String ? int.parse(json['id']) : json['id'];
    tripEndPoint = json['tripEndPoint'];
    tripType = json['serviceType'];
    tripNumber = json['tripNumber'];
    tripStatus = json['tripStatus'];
    creationDate = json['creationDate'];
    stringDate = json['stringDate'];
    cancelledBy = json['cancelledByEnum'];
    date = json['date'];
    notes = json['notes'];
    paymentValue = (json['clientOffer'] != null)
        ? dynamicToDouble(json['clientOffer'])
        : null;
    pickupLocation = json['pickupLocation'] == null
        ? TransportationLocation()
        : TransportationLocation.fromJson(json['pickupLocation'] is String
            ? jsonDecode(json['pickupLocation'])
            : json['pickupLocation']);
    destinationLocation = json['destination'] == null
        ? TransportationLocation()
        : TransportationLocation.fromJson(json['destination'] is String
            ? jsonDecode(json['destination'])
            : json['destination']);
    if (json['offers'] != null && json['offers'].isNotEmpty) {
      offers = List<OfferModel>.from(
          json["offers"].map((x) => OfferModel.fromJson(x)));
    }
    if (json['acceptedOffer'] != null) {
      acceptedOffer = AcceptedOffer.fromJson(json['acceptedOffer']);
    }
    return this;
  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> data = <String, dynamic>{};
    // if (tripId != null) data['id'] = tripId.toString();
    if (creationDate != null) data['creationDate'] = creationDate;
    if (stringDate != null) data['stringDate'] = stringDate;
    if (date != null) data['date'] = date;
    if (notes != null) data['notes'] = notes;
    if (cancelledBy != null) data['cancelledByEnum'] = cancelledBy;
    if (paymentValue != null) data['clientOffer'] = paymentValue.toString();
    if (pickupLocation.latitude != null && pickupLocation.longitude != null) {
      data['pickupLocation'] = json.encode(pickupLocation.toJson());
    }
    if (destinationLocation.latitude != null &&
        destinationLocation.longitude != null) {
      data['destination'] = json.encode(destinationLocation.toJson());
    }
    if (tripType != null) data['serviceType'] = tripType;
    if (tripNumber != null) data['tripNumber'] = tripNumber;
    if (tripStatus != null) data['tripStatus'] = tripStatus;
    return data;
  }
}

class TransportationLocation {
  String? locationName;
  double? latitude;
  double? longitude;
  String? cityName;

  TransportationLocation();

  TransportationLocation.fromJson(Map<String, dynamic> json) {
    locationName = json['locationName'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    cityName = json['cityName'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};

    data['locationName'] = locationName;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['cityName'] = cityName;

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
