import 'dart:async';
import 'package:taxi_for_you/core/utils/resources/validations_manager.dart';

import '../../base/baseviewmodel.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../../../core/utils/resources/strings_manager.dart';
import '../../../data/model/user-model.dart';

class RegisterViewModel extends BaseViewModel {
  //Constant List
  List<String> genderTypes = [
    AppStrings.male.tr(),
    AppStrings.female.tr(),
  ];
  var user = UserModel();

  RegisterViewModel();

  // inputs
  @override
  void start() {}

  @override
  void dispose() {}
}
