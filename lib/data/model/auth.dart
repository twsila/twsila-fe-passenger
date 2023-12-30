class AuthModel {
  final String accesstoken;
  final String refreshToken;

  AuthModel({
    required this.accesstoken,
    required this.refreshToken,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        accesstoken: json["accessToken"],
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accesstoken,
        "refreshToken": refreshToken,
      };
}
