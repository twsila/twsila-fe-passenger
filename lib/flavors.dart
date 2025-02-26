enum Flavor {
  development,
  staging,
  production,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static const String awsDevBaseUrl =
      'http://ec2-54-90-154-31.compute-1.amazonaws.com:8080/';
  static const String awsStagingBaseUrl =
      'http://ec2-54-224-0-122.compute-1.amazonaws.com:8080/';

  static String get title {
    switch (appFlavor) {
      case Flavor.development:
        return 'D-Twsila';
      case Flavor.staging:
        return 'S-Twsila';
      case Flavor.production:
        return 'Twsila';
      default:
        return 'title';
    }
  }

  static String get baseUrl {
    switch (appFlavor) {
      case Flavor.development:
        return awsDevBaseUrl;
      case Flavor.staging:
        return awsStagingBaseUrl;
      case Flavor.production:
        return awsStagingBaseUrl;
      default:
        return awsStagingBaseUrl;
    }
  }
}
