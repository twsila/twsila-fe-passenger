enum Flavor {
  development,
  staging,
  production,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

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
        return 'http://54.89.92.148:8080/';
      case Flavor.staging:
        return 'http://54.89.92.148:8080/';
      case Flavor.production:
        return 'http://54.89.92.148:8080/';
      default:
        throw Exception('App flavor is not set');
    }
  }
}
