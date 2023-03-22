class UserModel {
  int? id;
  String? email;
  String? userName;
  String? countryCode;
  String? mobileNumber;
  String? gender;
  String? birthdate;

  UserModel({
    this.id,
    this.email,
    this.userName,
    this.countryCode,
    this.mobileNumber,
    this.gender,
    this.birthdate,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    userName = json['userName'];
    countryCode = json['countryCode'];
    mobileNumber = json['mobileNumber'];
    birthdate = json['birthdate'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    data['email'] = email;
    data['userName'] = userName;
    data['countryCode'] = countryCode;
    data['mobileNumber'] = mobileNumber;
    data['birthdate'] = birthdate;
    data['gender'] = gender;
    return data;
  }
}
