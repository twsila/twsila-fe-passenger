class Constants {
  static const String baseUrl =
      "https://twsila-dev-service-f33wiujt7a-lm.a.run.app/";
  static const String token = "SEND TOKEN HERE";
  static const String empty = "";
  static const int apiTimeOut = 60;
  static const int otpCountTime = 60;
  static const String GOOGLE_API_KEY_ANDROID =
      "AIzaSyAemSFn6fVufROQDewj0BjzuOKVw_Bxi8M";
  static const String GOOGLE_API_KEY_IOS =
      "AIzaSyDB2c1bJWwqm-XSTIopQZovNnRPfXnyd8s";
  static const headers = {
    "Accept": "*/*",
    'Authorization':
        "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIwMTAwMTA4MTMyNyIsImlhdCI6MTY4MzI4OTc5MywiZXhwIjoxNjgzMzMyOTkzfQ.pI_WhlesCN77xhJjyE5t6UNNNNL4wFIOk6xkpA-DNnNFZ4cgS_MvbCoizZX4Xwo9FWHm2v2dIT1t4CqrKykV2w",
    "Content-Type": "application/json"
  };
  static const multiPartHeaders = {
    "Accept": "application/json",
    'Authorization':
        'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIwMTAwMTA4MTMyNyIsImlhdCI6MTY4MzI4OTc5MywiZXhwIjoxNjgzMzMyOTkzfQ.pI_WhlesCN77xhJjyE5t6UNNNNL4wFIOk6xkpA-DNnNFZ4cgS_MvbCoizZX4Xwo9FWHm2v2dIT1t4CqrKykV2w',
    "Content-Type": "multipart/form-data"
  };
}

class EndPointsConstants {
  static const String login = "passenger/login";
  static const String register = "passenger/register-passenger";
  static const String generateOtp = "otp/generate";
  static const String validateOtp = "otp/validate";
}
