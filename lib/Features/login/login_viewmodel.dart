import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:taxi_for_you/Features/login/widgets/phone_view.dart';

import '../base/baseviewmodel.dart';
import '../common/state_renderer/state_renderer.dart';
import '../common/state_renderer/state_renderer_impl.dart';
import '../otp/view/verify_otp_view.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  String initialCountry = 'SA';
  final PageController pageController = PageController(initialPage: 0);
  final List<Widget> widgets = [
    const PhoneLoginView(),
    VerifyOtpView(),
  ];
  //Stream Input Controllers
  final StreamController _countryCodeStreamController =
      StreamController<String>.broadcast();
  final StreamController _phoneNumberStreamController =
      StreamController<String>.broadcast();
  final StreamController _pageStreamController = StreamController.broadcast();

  //Stream Success Controller
  StreamController isUserLoggedInSuccessfullyStreamController =
      StreamController<bool>.broadcast();

  LoginViewModel();

  // inputs
  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
    _pageStreamController.close();
    _countryCodeStreamController.close();
    _phoneNumberStreamController.close();
    isUserLoggedInSuccessfullyStreamController.close();
  }

  @override
  void start() {
    // view model should tell view please show content state
    inputState.add(ContentState());
  }

  @override
  Sink get inputPhoneNumber => _phoneNumberStreamController.sink;

  @override
  Sink get inputCountryCode => _countryCodeStreamController.sink;

  @override
  setPhoneNumber(String phoneNumber) {
    inputPhoneNumber.add(phoneNumber);
  }

  @override
  setCountryCode(String countryCode) {
    inputCountryCode.add(countryCode);
  }

  @override
  login() async {}

  void goNext() {
    pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.bounceInOut,
    );
    inputPageController.add(1);
  }

  void goPrevious() {
    pageController.animateToPage(
      0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.bounceInOut,
    );
    inputPageController.add(0);
  }

  @override
  Sink get inputPageController => _pageStreamController.sink;

  @override
  Stream<int> get outputPageController =>
      _pageStreamController.stream.map((sliderViewObject) => sliderViewObject);
}

abstract class LoginViewModelInputs {
  //Login Methods
  setCountryCode(String countryCode);
  setPhoneNumber(String phoneNumber);
  login();

  //Login Inputs
  Sink get inputCountryCode;
  Sink get inputPhoneNumber;
  Sink get inputPageController;
}

abstract class LoginViewModelOutputs {
  // stream controller output
  Stream<int> get outputPageController;
}
