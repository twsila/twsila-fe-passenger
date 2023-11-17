class CountryModel {
  final int countryID;
  final String countryName;
  final String country;
  final String countryCode;
  final String imageURL;

  CountryModel({
    required this.countryID,
    required this.countryName,
    required this.countryCode,
    required this.country,
    required this.imageURL,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        countryID: json["countryID"],
        countryName: json["countryName"],
        countryCode: json["countryCode"],
        country: json["country"],
        imageURL: json["imageURL"],
      );

  Map<String, dynamic> toJson() => {
        "countryID": countryID,
        "countryName": countryName,
        "countryCode": countryCode,
        "country": country,
        "imageURL": imageURL,
      };
}
