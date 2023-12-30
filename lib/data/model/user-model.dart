import 'package:taxi_for_you/data/model/user-device.dart';

class UserModel {
  int? userid;
  String? firstName;
  String? lastName;
  String? mobileNumber;
  String? email;
  String? gender;
  String? dateOfBirth;
  String? countryCode;
  UserDevice? userDevice;

  UserModel({
    this.userid,
    this.firstName,
    this.lastName,
    this.mobileNumber,
    this.email,
    this.gender,
    this.dateOfBirth,
    this.countryCode,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    userid = json['user']['passenger']['passengerId'];
    firstName = json['user']['passenger']['firstName'];
    lastName = json['user']['passenger']['lastName'];
    mobileNumber = json['user']['passenger']['mobile'];
    email = json['user']['passenger']['email'];
    dateOfBirth = json['user']['passenger']['dateOfBirth'];
    gender = json['user']['passenger']['gender'];
    countryCode = json['user']['passenger']['countryCode'];
    if (json['userDevice'] != null) {
      UserDevice.fromJson(json['mobileUserDevice']);
    }
  }

  UserModel.fromCachedJson(Map<String, dynamic> json) {
    userid = json['passengerId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobileNumber = json['mobile'];
    email = json['email'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
    countryCode = json['countryCode'];
    if (json['userDevice'] != null) {
      UserDevice.fromJson(json['mobileUserDevice']);
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    if (userid != null) {
      data['passengerId'] = userid;
    }
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['mobile'] = mobileNumber;
    data['dateOfBirth'] = dateOfBirth;
    data['gender'] = gender;
    data['countryCode'] = countryCode;
    if (userDevice != null) data['userDevice'] = userDevice!.toJson();
    return data;
  }
}
