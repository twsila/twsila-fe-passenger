import 'dart:async';
import 'package:taxi_for_you/core/utils/resources/validations_manager.dart';

import '../../base/baseviewmodel.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../../../core/utils/resources/strings_manager.dart';
import '../../model/user-model.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInput, RegisterViewModelOutput {
  //Constant List
  List<String> genderTypes = [
    AppStrings.male.tr(),
    AppStrings.female.tr(),
  ];

  //Streams
  StreamController userNameStreamController =
      StreamController<String>.broadcast();
  StreamController emailStreamController = StreamController<String>.broadcast();
  StreamController genderStreamController =
      StreamController<String>.broadcast();
  StreamController areAllInputsValidStreamController =
      StreamController<void>.broadcast();

  StreamController isUserRegisteredInSuccessfullyStreamController =
      StreamController<bool>();

  var user = UserModel();

  RegisterViewModel();

  // inputs
  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    userNameStreamController.close();
    emailStreamController.close();
    genderStreamController.close();
    areAllInputsValidStreamController.close();
    isUserRegisteredInSuccessfullyStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputEmail => emailStreamController.sink;

  @override
  Sink get inputUserName => userNameStreamController.sink;

  @override
  Sink get inputGender => genderStreamController.sink;

  @override
  Sink get inputAllInputsValid => areAllInputsValidStreamController.sink;

  @override
  register() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));

    // (await _registerUseCase.execute(RegisterUseCaseInput(
    //         registerObject.userName,
    //         registerObject.countryMobileCode,
    //         registerObject.mobileNumber,
    //         registerObject.email,
    //         registerObject.password,
    //         registerObject.profilePicture)))
    //     .fold(
    //         (failure) => {
    //               // left -> failure
    //               inputState.add(ErrorState(
    //                   StateRendererType.popupErrorState, failure.message))
    //             }, (data) {
    //   // right -> data (success)
    //   // content
    await Future.delayed(const Duration(seconds: 2));
    inputState.add(ContentState());
    //   // navigate to main screen
    isUserRegisteredInSuccessfullyStreamController.add(true);
    // });
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    if (_isUserNameValid(userName)) {
      user.userName = userName;
    }
    validate();
  }

  @override
  setCountryCode(String countryCode) {
    if (countryCode.isNotEmpty) {
      user.countryCode = countryCode;
    }
  }

  @override
  setMobileNumber(String mobileNumber) {
    if (mobileNumber.isNotEmpty) {
      user.mobileNumber = mobileNumber;
    }
  }

  @override
  setGender(String gender) {
    if (gender.isNotEmpty) {
      user.gender = gender;
    }
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if (AppValidations.isEmailValid(email)) {
      user.email = email;
    }
    validate();
  }

  @override
  setDate(String date) {
    if (date.isNotEmpty) {
      user.birthdate = date;
    }
  }

  // -- outputs
  //Username
  @override
  Stream<bool> get outputIsUserNameValid => userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<String?> get outputErrorUserName => outputIsUserNameValid
      .map((isUserName) => isUserName ? null : AppStrings.userNameInvalid.tr());

  //Email
  @override
  Stream<bool> get outputIsEmailValid => emailStreamController.stream
      .map((email) => AppValidations.isEmailValid(email));

  @override
  Stream<String?> get outputErrorEmail => outputIsEmailValid.map(
      (isEmailValid) => isEmailValid ? null : AppStrings.invalidEmail.tr());

  //Gender
  @override
  Stream<bool> get outputIsGenderValid =>
      genderStreamController.stream.map((gender) => gender != null);

  @override
  Stream<String?> get outputErrorGender => outputIsGenderValid.map(
      (isGenderValid) => isGenderValid ? null : AppStrings.invalidGender.tr());

  @override
  Stream<bool> get outputAreAllInputsValid =>
      areAllInputsValidStreamController.stream.map((_) => _areAllInputsValid());

  // --  private functions

  bool _isUserNameValid(String userName) {
    return userName.length >= 3;
  }

  bool _areAllInputsValid() {
    return user.countryCode != null &&
        user.countryCode!.isNotEmpty &&
        user.mobileNumber != null &&
        user.mobileNumber!.isNotEmpty &&
        user.userName != null &&
        user.userName!.isNotEmpty &&
        user.email != null &&
        user.email!.isNotEmpty &&
        user.gender != null &&
        user.gender!.isNotEmpty;
  }

  validate() {
    inputAllInputsValid.add(null);
  }
}

abstract class RegisterViewModelInput {
  Sink get inputUserName;
  Sink get inputEmail;
  Sink get inputGender;
  Sink get inputAllInputsValid;

  register();

  setUserName(String userName);
  setEmail(String email);
  setCountryCode(String countryCode);
  setMobileNumber(String mobileNumber);
  setGender(String gender);
  setDate(String date);
}

abstract class RegisterViewModelOutput {
  Stream<bool> get outputIsUserNameValid;
  Stream<String?> get outputErrorUserName;

  Stream<bool> get outputIsGenderValid;
  Stream<String?> get outputErrorGender;

  Stream<bool> get outputIsEmailValid;
  Stream<String?> get outputErrorEmail;

  Stream<bool> get outputAreAllInputsValid;
}
