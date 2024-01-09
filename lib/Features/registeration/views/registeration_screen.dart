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
import 'package:taxi_for_you/app/app_prefs.dart';

import '../../../app/di.dart';
import '../../../core/utils/resources/color_manager.dart';
import '../../../core/utils/resources/routes_manager.dart';
import '../../../core/utils/resources/strings_manager.dart';
import '../../common/state_renderer/dialogs.dart';
import '../../common/widgets/custom_date_picker.dart';
import '../../common/widgets/custom_text_button.dart';
import '../../common/widgets/custom_text_input_field.dart';
import '../../login/bloc/login_bloc.dart';
import '../../login/bloc/login_event.dart';
import '../../login/bloc/login_state.dart';

class RegistrationScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _isInit = true;
  bool displayLoadingIndicator = false;
  final RegisterationViewModel _viewModel = instance<RegisterationViewModel>();
  final _formKey = GlobalKey<FormState>();

  _bind() {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    _viewModel.start();
    _viewModel.setArguments(arguments);
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
      _viewModel.isValid = _formKey.currentState != null &&
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
            BlocProvider.of<LoginBloc>(context)
                .add(LoginUser(mobileNumber: _viewModel.user.mobileNumber!));
          } else if (state is EditUserFailed) {
            ShowDialogHelper.showErrorMessage(
                state.baseResponse.errorMessage!, context);
          } else if (state is EditUserSuccessfully) {
            ShowDialogHelper.showSuccessMessage(
                AppStrings.editSuccess.tr(), context);
            Navigator.pop(context);
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
                        _viewModel.isEdit
                            ? AppStrings.editProfile.tr()
                            : AppStrings.continueRegistration.tr(),
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
                                initialDate: _viewModel.user.dateOfBirth,
                                lastDate: DateTime(2005),
                                isDateOnly: true,
                                onSelectDate: (String date) {
                                  _viewModel.user.dateOfBirth = date;
                                  Future.delayed(const Duration(seconds: 1),
                                      () => checkValidations());
                                },
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: GenderWidget(
                                initialGender: _viewModel.user.gender,
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
                  text: _viewModel.isEdit
                      ? AppStrings.edit.tr()
                      : AppStrings.save.tr(),
                  onPressed: _viewModel.isValid
                      ? () {
                          FocusScope.of(context).unfocus();
                          _viewModel.isEdit
                              ? BlocProvider.of<RegistrationBloc>(context)
                                  .add(EditUser(userModel: _viewModel.user))
                              : BlocProvider.of<RegistrationBloc>(context).add(
                                  RegistrationUser(userModel: _viewModel.user));
                        }
                      : null,
                ),
              ),
            ),
            BlocListener<LoginBloc, LoginStates>(
              listener: (context, state) {
                if (state is LoginSuccessfully) {
                  Navigator.pushNamed(
                    context,
                    Routes.homeRoute,
                  );
                } else if (state is LoginFailed) {
                  ShowDialogHelper.showErrorMessage(
                      AppStrings.defaultError.tr(), context);
                }
              },
              child: const SizedBox(),
            ),
          ],
        );
      },
    );
  }
}
