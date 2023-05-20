class UserDevice {
  String registrationId;
  String deviceOs;
  String appVersion;

  UserDevice({
    required this.registrationId,
    required this.appVersion,
    required this.deviceOs,
  });

  Map<String, dynamic> toJson() => {
        "registrationId": registrationId,
        "deviceOs": deviceOs,
        "appVersion": appVersion,
      };
}
