class Constants {
  static const String baseUrl =
      "https://twsila-dev-service-f33wiujt7a-lm.a.run.app/";
  static const String baseUrlMultiPart =
      "twsila-dev-service-f33wiujt7a-lm.a.run.app";
  static const int apiTimeOut = 30;
  static const int otpCountTime = 60;
  static const String GOOGLE_API_KEY_ANDROID =
      "AIzaSyAemSFn6fVufROQDewj0BjzuOKVw_Bxi8M";
  static const String GOOGLE_API_KEY_IOS =
      "AIzaSyDB2c1bJWwqm-XSTIopQZovNnRPfXnyd8s";
  static const String constAuth =
      "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIwMTAwMTA4MTMyNyIsImlhdCI6MTY4MzI4OTc5MywiZXhwIjoxNjgzMzMyOTkzfQ.pI_WhlesCN77xhJjyE5t6UNNNNL4wFIOk6xkpA-DNnNFZ4cgS_MvbCoizZX4Xwo9FWHm2v2dIT1t4CqrKykV2w";

  static const headers = {"Accept": "*/*", "Content-Type": "application/json"};
  static const multiPartHeaders = {
    "Accept": "application/json",
    "Content-Type": "multipart/form-data"
  };
}

class TripTypeConstants {
  static const String carAidType = "CAR_AID";
  static const String drinkWaterType = "DRINK_WATER_TANK";
  static const String frozenType = "FROZEN";
  static const String furnitureType = "FURNITURE";
  static const String goodsType = "GOODS";
  static const String otherTankType = "OTHER_TANK";
  static const String personType = "PERSON";
}

class EndPointsConstants {
  static const String lookups = 'lookup';
  static const String login = "passenger/login";
  static const String register = "passenger/register-passenger";
  static const String generateOtp = "otp/generate";
  static const String validateOtp = "otp/validate";
  static const String tripDetails = "passengers/trips/details";
  static const String getDraftTrip = "passengers/trips/draft";
  static const String userTrips = "passengers/offers/select-trip";
  static const String acceptOffer = "passengers/offers/accept";
  static const String cancelTrip = "passengers/trips/cancel";
  static const String sendFurnitureRequest = 'trips/insert-furniture-trip';
  static const String sendGoodsRequest = 'trips/insert-goods-trip';
  static const String sendCarAidRequest = 'trips/insert-car-aid-trip';
  static const String sendFreezersRequest = 'trips/insert-frozen-trip';
  static const String sendWaterRequest = 'trips/insert-water-tank-trip';
  static const String sendCisternsRequest = 'trips/insert-other-tank-trip';
}
