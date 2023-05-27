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

  // inputs
  @override
  void start() {}

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    mobileNumberController.dispose();
    emailController.dispose();
  }
}
