class UserDevice {
  String? registrationId;
  String? deviceOs;
  String? appVersion;

  UserDevice({
    this.registrationId,
    this.appVersion,
    this.deviceOs,
  });

  UserDevice.fromJson(Map<String, dynamic> json) {
    registrationId = json['registrationId'];
    deviceOs = json['deviceOS'];
    appVersion = json['appVersion'];
  }

  Map<String, dynamic> toJson() => {
        "registrationId": registrationId,
        "deviceOs": deviceOs,
        "appVersion": appVersion,
      };
}
