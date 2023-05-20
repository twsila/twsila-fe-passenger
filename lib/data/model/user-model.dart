class UserModel {
  String? firstName;
  String? lastName;
  String? mobileNumber;
  String? email;
  String? gender;
  String? dateOfBirth;
  String? token;

  UserModel({
    this.firstName,
    this.lastName,
    this.mobileNumber,
    this.email,
    this.gender,
    this.dateOfBirth,
    this.token,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobileNumber = json['mobile'];
    email = json['email'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    if (token != null) data['token'] = token;
    data['firstName'] = email;
    data['lastName'] = email;
    data['email'] = email;
    data['mobile'] = mobileNumber;
    data['dateOfBirth'] = dateOfBirth;
    data['gender'] = gender;
    return data;
  }
}
