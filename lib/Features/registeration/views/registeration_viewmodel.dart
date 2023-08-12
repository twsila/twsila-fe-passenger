import 'package:flutter/cupertino.dart';
import 'package:taxi_for_you/Features/registeration/models/gender_model.dart';

import '../../base/baseviewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../core/utils/resources/strings_manager.dart';
import '../../../data/model/user-model.dart';

class RegisterationViewModel extends BaseViewModel {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  //Constant List
  List<GenderModel> genderTypes = [
    GenderModel(value: 'M', name: AppStrings.male.tr()),
    GenderModel(value: 'F', name: AppStrings.female.tr()),
  ];
  var user = UserModel();
  bool isEdit = false;
  bool isValid = false;
  late ValueNotifier notifier;

  // inputs
  @override
  void start() {}

  setArguments(Map arguments) {
    if (arguments["mobile"] != null) {
      mobileNumberController.text = arguments["mobile"];
      user.mobileNumber = arguments["mobile"];
      user.gender = genderTypes[0].value;
    }
    if (arguments["user"] != null) {
      user = arguments["user"];
      notifier = arguments["notifier"];
      mobileNumberController.text = user.mobileNumber!;
      firstNameController.text = user.firstName!;
      lastNameController.text = user.lastName!;
      emailController.text = user.email!;
      isValid = true;
    }
    if (arguments["isEdit"] != null) {
      isEdit = arguments["isEdit"];
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    mobileNumberController.dispose();
    emailController.dispose();
  }
}
