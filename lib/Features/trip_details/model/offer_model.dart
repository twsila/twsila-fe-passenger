import '../../../data/model/driver.dart';

class AcceptedOffer {
  final int acceptedOfferId;
  final OfferModel offer;

  AcceptedOffer({required this.acceptedOfferId, required this.offer});

  factory AcceptedOffer.fromJson(Map<String, dynamic> json) => AcceptedOffer(
        acceptedOfferId: json['id'],
        offer: OfferModel.fromJson(json['offer']),
      );
}

class OfferModel {
  final int offerId;
  final double driverOffer;
  final String? acceptanceStatus;
  final String? creationDate;
  final DriverModel driverModel;
  final bool? woman;

  OfferModel({
    required this.offerId,
    required this.driverModel,
    required this.acceptanceStatus,
    required this.creationDate,
    required this.driverOffer,
    this.woman,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
        offerId: json['id'],
        driverModel: DriverModel.fromJson(json['driver']),
        acceptanceStatus: json['acceptanceStatus'],
        creationDate: json['creationDate'],
        driverOffer: json['driverOffer'],
        woman: json['woman'],
      );
}
