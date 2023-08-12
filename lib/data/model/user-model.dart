import 'package:taxi_for_you/data/model/user-device.dart';

class UserModel {
  int? userid;
  String? firstName;
  String? lastName;
  String? mobileNumber;
  String? email;
  String? gender;
  String? dateOfBirth;
  String? token;
  String? tokenExpirationTime;
  UserDevice? userDevice;

  UserModel({
    this.userid,
    this.firstName,
    this.lastName,
    this.mobileNumber,
    this.email,
    this.gender,
    this.dateOfBirth,
    this.token,
    this.tokenExpirationTime,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    userid = json['passengerId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobileNumber = json['mobile'];
    email = json['email'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
    token = json['token'];
    tokenExpirationTime = json['tokenExpirationTime'];
    if (json['userDevice'] != null) UserDevice.fromJson(json['userDevice']);
  }

  Map<String, dynamic> toJson(bool isCaching) {
    Map<String, dynamic> data = <String, dynamic>{};
    data['passengerId'] = userid;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['mobile'] = mobileNumber;
    data['dateOfBirth'] = dateOfBirth;
    data['gender'] = gender;
    if (isCaching) data['token'] = token;
    if (userDevice != null) data['userDevice'] = userDevice!.toJson();
    return data;
  }
}
