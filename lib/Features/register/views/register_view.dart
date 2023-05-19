import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:taxi_for_you/Features/common/widgets/custom_back_button.dart';
import 'package:taxi_for_you/Features/common/widgets/custom_date_picker.dart';
import 'package:taxi_for_you/Features/common/widgets/custom_text_button.dart';
import 'package:taxi_for_you/Features/common/widgets/custom_text_input_field.dart';
import 'package:taxi_for_you/Features/login/login_viewmodel.dart';
import 'package:taxi_for_you/Features/register/views/register_viewmodel.dart';
import 'package:taxi_for_you/core/utils/ext/screen_size_ext.dart';
import 'package:taxi_for_you/core/utils/resources/font_manager.dart';
import 'package:taxi_for_you/core/utils/resources/styles_manager.dart';

import '../../../app/app_prefs.dart';
import '../../../app/di.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../../../core/utils/resources/color_manager.dart';
import '../../../core/utils/resources/routes_manager.dart';
import '../../../core/utils/resources/strings_manager.dart';
import '../../common/widgets/custom_dropdown.dart';
import '../../common/widgets/custom_phone_input_field.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _registerViewModel = instance<RegisterViewModel>();
  final LoginViewModel _loginViewModel = instance<LoginViewModel>();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final _formKey = GlobalKey<FormState>();
  String? _intialValue;

  final TextEditingController _userNameEditingController =
      TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();

  _bind() {
    _intialValue = _registerViewModel.genderTypes[0];
    _registerViewModel.setGender(_intialValue!);
    _registerViewModel.start();
    // _registerViewModel.setCountryCode(_loginViewModel.loginObject.countryCode);
    // _registerViewModel.setMobileNumber(_loginViewModel.loginObject.phoneNumber);
    _userNameEditingController.addListener(() {
      _registerViewModel.setUserName(_userNameEditingController.text);
    });
    _emailEditingController.addListener(() {
      _registerViewModel.setEmail(_emailEditingController.text);
    });
    _registerViewModel.isUserRegisteredInSuccessfullyStreamController.stream
        .listen((isLoggedIn) {
      if (isLoggedIn) {
        // navigate to main screen
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _appPreferences.setUserLoggedIn();
          // _appPreferences
          //     .setUserDevices(_loginViewModel.loginObject.phoneNumber);
          Navigator.of(context).pushReplacementNamed(Routes.categoriesRoute);
        });
      }
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: _getContentWidget(),
    );
  }

  Widget _getContentWidget() {
    return SafeArea(
      child: Container(
          margin: const EdgeInsets.all(28),
          padding: const EdgeInsets.only(top: 16),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                    child: CustomBackButton(
                      onPressed: () {
                        _appPreferences.logout(context);
                      },
                    ),
                  ),
                  const SizedBox(height: 28),
                  Container(
                    margin: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppStrings.createNewAccount.tr(),
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                AppStrings.letsGetStarted.tr(),
                                style: getMediumStyle(
                                    color: ColorManager.black, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 28,
                        ),
                        StreamBuilder<String?>(
                            stream: _registerViewModel.outputErrorUserName,
                            builder: (context, snapshot) {
                              return CustomTextInputField(
                                controller: _userNameEditingController,
                                prefixIcon: const Icon(Icons.person_outline),
                                hintText: AppStrings.username.tr(),
                                labelText: AppStrings.username.tr(),
                                errorLabel: snapshot.data,
                              );
                            }),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomPhoneInputField(
                          enabled: false,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        StreamBuilder<String?>(
                            stream: _registerViewModel.outputErrorEmail,
                            builder: (context, snapshot) {
                              return CustomTextInputField(
                                controller: _emailEditingController,
                                prefixIcon: const Icon(Icons.email_outlined),
                                hintText: AppStrings.emailHint.tr(),
                                labelText: AppStrings.emailHint.tr(),
                                errorLabel: snapshot.data,
                              );
                            }),
                        StreamBuilder<bool?>(
                            stream: _registerViewModel.outputIsGenderValid,
                            builder: (context, snapshot) {
                              return CustomDropDown(
                                stringsArr: _registerViewModel.genderTypes,
                                intialValue: _intialValue,
                                isValid: snapshot.data ?? true,
                                hintText: AppStrings.gender.tr(),
                                iconData: Icons.male,
                                borderColor: ColorManager.lightGrey,
                                errorMessage: AppStrings.invalidGender.tr(),
                                onChanged: (value) {
                                  _registerViewModel.setGender(value!);
                                  setState(() {
                                    _intialValue = value;
                                  });
                                },
                              );
                            }),
                        CustomDatePickerWidget(
                          mainColor: ColorManager.lightGrey,
                          hintText: AppStrings.birthdate.tr(),
                          isDateOnly: true,
                          onSelectDate: (date) {
                            _registerViewModel.setDate(date);
                          },
                        ),
                        const SizedBox(height: 40),
                        StreamBuilder<bool>(
                            stream: _registerViewModel.outputAreAllInputsValid,
                            builder: (context, snapshot) {
                              return SizedBox(
                                width: double.infinity,
                                height: 40,
                                child: CustomTextButton(
                                  onPressed: (snapshot.data ?? false)
                                      ? () {
                                          _registerViewModel.register();
                                        }
                                      : null,
                                  text: AppStrings.register.tr(),
                                ),
                              );
                            }),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppStrings.alreadyHaveAccount.tr(),
                                style: getBoldStyle(
                                    color: ColorManager.black, fontSize: 16),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                AppStrings.login.tr(),
                                style: getBoldStyle(
                                    color: ColorManager.primary, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

  @override
  void dispose() {
    _registerViewModel.dispose();
    super.dispose();
  }
}
