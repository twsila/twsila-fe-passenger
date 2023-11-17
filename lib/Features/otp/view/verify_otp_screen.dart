import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:taxi_for_you/Features/common/state_renderer/dialogs.dart';
import 'package:taxi_for_you/Features/common/widgets/custom_scaffold.dart';
import 'package:taxi_for_you/Features/common/widgets/page_builder.dart';
import 'package:taxi_for_you/Features/login/bloc/login_bloc.dart';
import 'package:taxi_for_you/Features/login/bloc/login_event.dart';
import 'package:taxi_for_you/Features/login/bloc/login_state.dart';
import 'package:taxi_for_you/Features/otp/bloc/otp_bloc.dart';
import 'package:taxi_for_you/Features/otp/bloc/otp_event.dart';
import 'package:taxi_for_you/Features/otp/bloc/otp_state.dart';
import 'package:taxi_for_you/Features/otp/view/verify_otp_viewmodel.dart';
import 'package:taxi_for_you/Features/otp/view/widgets/custom_text_widget.dart';
import 'package:taxi_for_you/Features/otp/view/widgets/custom_timer_widget.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';
import '../../../core/utils/resources/routes_manager.dart';
import '../../common/widgets/custom_verification_code_widget.dart';

class VerifyOtpScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  VerifyOtpScreen({Key? key}) : super(key: key);

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  bool _isInit = true;
  bool displayLoadingIndicator = false;
  bool? doneSending;
  String? userOtp;
  String? appSignature;
  final VerifyOTPViewModel _viewModel = VerifyOTPViewModel();

  @override
  void dispose() {
    _viewModel.disponse();
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      _viewModel.mobileNumber =
          ModalRoute.of(context)!.settings.arguments as String;
      appSignature = await SmsAutoFill().getAppSignature;
      BlocProvider.of<OtpBloc>(context).add(GenerateOtpEvent(
        mobileNumber: _viewModel.mobileNumber,
        appSignature: appSignature,
      ));
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OtpBloc, OtpStates>(
      listener: (context, state) {
        if (state is GenerateOtpIsLoading || state is ValidateOtpIsLoading) {
          setState(() {
            displayLoadingIndicator = true;
          });
        } else {
          setState(() {
            displayLoadingIndicator = false;
          });
        }
        if (state is GenerateOtpSuccessfully) {
          print(AppStrings.codeIs.tr() + state.otp);
          setState(() {
            doneSending = true;
          });
          userOtp = state.otp;
          ShowDialogHelper.showSuccessMessage(
            AppStrings.codesent.tr(),
            context,
            seconds: 5,
          );
        }

        if (state is GenerateOtpFailed) {
          setState(() {
            doneSending = false;
          });
          ShowDialogHelper.showErrorMessage(
              AppStrings.codeSenderror.tr(), context);
        }
        if (state is ValidateOtpSuccessfully) {
          ShowDialogHelper.showSuccessMessage(
              AppStrings.validateSuccessfully.tr(), context);
          Future.delayed(
              const Duration(seconds: 1),
              () => BlocProvider.of<LoginBloc>(context)
                  .add(LoginUser(mobileNumber: _viewModel.mobileNumber)));
        }
        if (state is ValidateOtpFailed) {
          ShowDialogHelper.showErrorMessage(
              AppStrings.validateFailed.tr(), context);
        }
      },
      child: CustomScaffold(
        pageBuilder: PageBuilder(
          displayLoadingIndicator: displayLoadingIndicator,
          scaffoldKey: widget.scaffoldKey,
          context: context,
          body: Container(
            margin: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomOtpTextWidget(mobileNumber: _viewModel.mobileNumber),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 32),
                    child: CustomVerificationCodeWidget(
                      autoFocus: false,
                      controller: _viewModel.mobileController,
                      onCodeSubmitted: (code) {},
                      onCodeChanged: (code) {
                        if (code.length == 6) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          BlocProvider.of<OtpBloc>(context).add(
                            ValidateOtpEvent(
                              otp: userOtp!,
                              generatedOtp: code,
                              mobileNumber: _viewModel.mobileNumber,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  CustomTimerWidget(
                    mobileNumber: _viewModel.mobileNumber,
                    doneSending: doneSending,
                    appSignature: appSignature,
                  ),
                  BlocListener<LoginBloc, LoginStates>(
                    listener: (context, state) {
                      if (state is LoginSuccessfully) {
                        Navigator.pushNamed(
                          context,
                          Routes.homeRoute,
                        );
                      } else if (state is LoginFailed) {
                        Navigator.pushNamed(
                          context,
                          Routes.registerRoute,
                          arguments: {"mobile": _viewModel.mobileNumber},
                        );
                      }
                    },
                    child: const SizedBox(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
