import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_for_you/Features/common/widgets/custom_scaffold.dart';
import 'package:taxi_for_you/Features/common/widgets/page_builder.dart';
import 'package:taxi_for_you/Features/registeration/bloc/registeration_bloc.dart';
import 'package:taxi_for_you/Features/registeration/bloc/registeration_event.dart';
import 'package:taxi_for_you/Features/registeration/bloc/registeration_state.dart';
import 'package:taxi_for_you/Features/registeration/views/registeration_viewmodel.dart';
import 'package:taxi_for_you/Features/registeration/views/widgets/gender_widget.dart';

import '../../../app/app_prefs.dart';
import '../../../app/di.dart';
import '../../../core/utils/resources/color_manager.dart';
import '../../../core/utils/resources/strings_manager.dart';
import '../../common/state_renderer/dialogs.dart';
import '../../common/widgets/custom_date_picker.dart';
import '../../common/widgets/custom_text_button.dart';
import '../../common/widgets/custom_text_input_field.dart';

class RegistrationScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _isInit = true;
  bool displayLoadingIndicator = false;
  bool _isValid = false;
  final RegisterationViewModel _viewModel = instance<RegisterationViewModel>();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.mobileNumberController.text =
        ModalRoute.of(context)!.settings.arguments as String;
    _viewModel.user.mobileNumber =
        ModalRoute.of(context)!.settings.arguments as String;
    _viewModel.user.gender = _viewModel.genderTypes[0].value;
    // _registerViewModel.start();
    // // _registerViewModel.setCountryCode(_loginViewModel.loginObject.countryCode);
    // // _registerViewModel.setMobileNumber(_loginViewModel.loginObject.phoneNumber);
    // _userNameEditingController.addListener(() {
    //   _registerViewModel.setUserName(_userNameEditingController.text);
    // });
    // _emailEditingController.addListener(() {
    //   _registerViewModel.setEmail(_emailEditingController.text);
    // });
    // _registerViewModel.isUserRegisteredInSuccessfullyStreamController.stream
    //     .listen((isLoggedIn) {
    //   if (isLoggedIn) {
    //     // navigate to main screen
    //     SchedulerBinding.instance.addPostFrameCallback((_) {
    //       _appPreferences.setUserLoggedIn();
    //       // _appPreferences
    //       //     .setUserDevices(_loginViewModel.loginObject.phoneNumber);
    //       Navigator.of(context).pushReplacementNamed(Routes.categoriesRoute);
    //     });
    //   }
    // });
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isInit = false;
      _bind();
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      pageBuilder: PageBuilder(
        scaffoldKey: widget.scaffoldKey,
        displayLoadingIndicator: displayLoadingIndicator,
        context: context,
        body: _getContentWidget(),
      ),
    );
  }

  checkValidations() {
    setState(() {
      _isValid = _formKey.currentState != null &&
          _formKey.currentState!.validate() &&
          _viewModel.user.dateOfBirth != null;
    });
  }

  Widget _getContentWidget() {
    return BlocConsumer<RegistrationBloc, RegistrationStates>(
      listener: (context, state) {
        if (state is RegistrationIsLoading) {
          setState(() {
            displayLoadingIndicator = true;
          });
        } else {
          setState(() {
            displayLoadingIndicator = false;
          });
          if (state is RegistrationFailed) {
            ShowDialogHelper.showErrorMessage(
                state.baseResponse.errorMessage!, context);
          } else if (state is RegistrationSuccessfully) {
            ShowDialogHelper.showSuccessMessage(
                AppStrings.registerSuccess.tr(), context);
          }
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            AppStrings.welcomeTo.tr() + ' ',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: ColorManager.black),
                          ),
                          Text(
                            AppStrings.appTitle.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: ColorManager.primary),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        AppStrings.continueRegistration.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: ColorManager.black,
                                fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 24),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: CustomTextInputField(
                                controller: _viewModel.firstNameController,
                                hintText: AppStrings.firstNameHint.tr(),
                                labelText: AppStrings.firstName.tr(),
                                errorLabel: AppStrings.firstNameError.tr(),
                                isRequired: true,
                                showLabelText: true,
                                validateEmptyString: true,
                                onChanged: (value) {
                                  _viewModel.user.firstName = value;
                                  checkValidations();
                                },
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: CustomTextInputField(
                                controller: _viewModel.lastNameController,
                                hintText: AppStrings.lastNameHint.tr(),
                                labelText: AppStrings.lastName.tr(),
                                errorLabel: AppStrings.lastNameError.tr(),
                                isRequired: true,
                                showLabelText: true,
                                validateEmptyString: true,
                                onChanged: (value) {
                                  _viewModel.user.lastName = value;
                                  checkValidations();
                                },
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: CustomTextInputField(
                                controller: _viewModel.mobileNumberController,
                                hintText: AppStrings.enterPhoneNumber.tr(),
                                labelText: AppStrings.phoneTitle.tr(),
                                errorLabel: AppStrings.mobileNumberInvalid.tr(),
                                enabled: false,
                                isRequired: true,
                                showLabelText: true,
                                validateEmptyString: true,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: CustomTextInputField(
                                controller: _viewModel.emailController,
                                hintText: AppStrings.emailHint.tr(),
                                labelText: AppStrings.emailTitle.tr(),
                                errorLabel: AppStrings.invalidEmail.tr(),
                                isRequired: true,
                                showLabelText: true,
                                validateEmail: true,
                                validateEmptyString: true,
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (value) {
                                  _viewModel.user.email = value;
                                  checkValidations();
                                },
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: CustomDatePickerWidget(
                                mainColor: ColorManager.lightGrey,
                                hintText: AppStrings.birthdate.tr(),
                                isDateOnly: true,
                                onSelectDate: (String date, DateTime dateTime) {
                                  String stringDate =
                                      DateFormat('dd/MM/yyyy').format(dateTime);

                                  _viewModel.user.dateOfBirth = stringDate;
                                  Future.delayed(const Duration(seconds: 1),
                                      () => checkValidations());
                                },
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: GenderWidget(
                                onSelectGender: (gender) {
                                  _viewModel.user.gender = gender.value;
                                  checkValidations();
                                },
                              ),
                            ),
                            const SizedBox(height: 100),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                child: CustomTextButton(
                  showIcon: false,
                  text: AppStrings.save.tr(),
                  onPressed: _isValid
                      ? () {
                          FocusScope.of(context).unfocus();
                          BlocProvider.of<RegistrationBloc>(context).add(
                              RegistrationUser(userModel: _viewModel.user));
                        }
                      : null,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
