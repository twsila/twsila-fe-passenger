class Constants {
  static const String baseUrl =
      "https://twsila-dev-service-f33wiujt7a-lm.a.run.app/";
  static const String baseUrlMultiPart =
      "twsila-dev-service-f33wiujt7a-lm.a.run.app";
  static const int apiTimeOut = 30;
  static const int otpCountTime = 60;
  static const String GOOGLE_API_KEY_ANDROID =
      "AIzaSyDudVHh73YAVrXD1CgiJPtIbFbquCmavlA";
  static const String GOOGLE_API_KEY_IOS =
      "AIzaSyD8KjkW8eLaDD3qeZIiPPDxqfdK8olftWs";
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
  static const String personType = "PERSONS";
}

class TripStatusConstants {
  static const String draft = "DRAFT";
  static const String submitted = "SUBMITTED";
  static const String evaluation = "EVALUATION";
  static const String payment = "PAYMENT";
  static const String waitForTakeOff = "WAIT_FOR_TAKEOFF";
  static const String takeOff = "TAKEOFF";
  static const String executed = "EXECUTED";
  static const String completed = "COMPLETED";
  static const String cancelled = "CANCELLED";
  static const String cancelledByDriver = "DRIVER";
  static const String cancelledByPassenger = "PASSENGER";
  static const String accepted = 'ACCEPTED';
}

class EndPointsConstants {
  static const String lookups = 'lookups';
  static const String lookupsByKey = 'lookups/by-key';
  static const String lookupCountries = 'lookups/country';
  static const String login = "api/v1/auth/login";
  static const String refreshToken = "/api/v1/auth/refresh-token";
  static const String logout = "/api/v1/auth/logout";
  static const String register = "passengers/register";
  static const String editProfile = "passengers/update-my-profile";
  static const String generateOtp = "otp/generate";
  static const String validateOtp = "otp/validate";
  static const String tripDetails = "passengers/trips/details";
  static const String getDraftTrip = "passengers/trips/draft";
  static const String userTrips = "passengers/offers/select-trip";
  static const String acceptOffer = "passengers/offers/accept";
  static const String cancelTrip = "passengers/trips/cancel";
  static const String rateTrip = "passengers/trips/rate";
  static const String sendTripRequest = 'trips/insert';
  static const String changeStatus = "passengers/trips/change-status";
}

class GetItInstanceNames {
  static const String lookups = "lookups";
  static const String vehicleTypes = "vehicleTypes";
}
