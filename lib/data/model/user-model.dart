class UserModel {
  String? username;
  String? mobileNumber;
  String? email;
  String? gender;
  String? dateOfBirth;

  UserModel({
    this.username,
    this.mobileNumber,
    this.email,
    this.gender,
    this.dateOfBirth,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    mobileNumber = json['mobile'];
    email = json['email'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['email'] = email;
    data['mobile'] = mobileNumber;
    data['dateOfBirth'] = dateOfBirth;
    data['gender'] = gender;
    return data;
  }
}
