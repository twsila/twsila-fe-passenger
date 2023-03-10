import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taxi_for_you/presentation/otp/viewmodel/verify_otp_viewmodel.dart';
import 'package:taxi_for_you/presentation/resources/strings_manager.dart';

import '../../../app/app_prefs.dart';
import '../../../app/di.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../../custom_widgets/custom_verification_code_widget.dart';
import '../../login/login_viewmodel.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class VerifyOtpView extends StatefulWidget {
  String? phoneNumber;

  VerifyOtpView({Key? key, this.phoneNumber}) : super(key: key);

  @override
  State<VerifyOtpView> createState() => _VerifyOtpViewState();
}

class _VerifyOtpViewState extends State<VerifyOtpView> {
  final VerifyOTPViewModel _viewModel = instance<VerifyOTPViewModel>();
  final _formKey = GlobalKey<FormState>();
  GlobalKey globalKey = GlobalKey();

  final AppPreferences _appPreferences = instance<AppPreferences>();

  _bind() {
    _viewModel.start();
    _viewModel.setPhoneNumber('+201147459828');
    _viewModel.generateOtp();
    _viewModel.isCodeIsSentStreamController.stream.listen((isOTPSent) {
      if (isOTPSent) {
        Fluttertoast.showToast(
            msg: "Code sent",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });

    _viewModel.isCodeIsVerifiedStreamController.stream
        .listen((isCodeIsVerified) {
      if (isCodeIsVerified) {
        // navigate to main screen
        SchedulerBinding.instance?.addPostFrameCallback((_) {
          _appPreferences.setUserLoggedIn();
          Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
        });
      }
    });
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
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
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          // _getContentWidget();
          return snapshot.data
                  ?.getScreenWidget(context, _getContentWidget(), () {}) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Container(
        height: double.infinity,
        padding: const EdgeInsets.only(
            top: AppPadding.p50, right: AppPadding.p20, left: AppPadding.p20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            const Image(
                                image: AssetImage(ImageAssets.languageIc)),
                            const SizedBox(
                              width: AppSize.s8,
                            ),
                            Text(
                              AppStrings.englishLabel.tr(),
                              style: getRegularStyle(
                                  color: ColorManager.black,
                                  fontSize: FontSize.s12),
                            ),
                          ],
                        )),
                    Row(
                      children: const [
                        Image(image: AssetImage(ImageAssets.lineGrey)),
                        SizedBox(
                          width: AppSize.s8,
                        ),
                        Image(image: AssetImage(ImageAssets.line)),
                      ],
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: AppSize.s60,
                      ),
                    ),
                  ],
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {},
                      child:
                          const Image(image: AssetImage(ImageAssets.backArrow)),
                    )),
                Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        AppStrings.phoneVerification.tr(),
                        style: getRegularStyle(
                            color: ColorManager.primary,
                            fontSize: FontSize.s30),
                      ),
                    )),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Image(image: AssetImage(ImageAssets.verifyOtpGraphic)),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStrings.enterOtpHint.tr(),
                    style: getRegularStyle(
                        color: ColorManager.black, fontSize: FontSize.s16),
                  ),
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await Future.delayed(const Duration(milliseconds: 500));
                        RenderObject? object =
                            globalKey.currentContext?.findRenderObject();
                        object?.showOnScreen();
                      },
                      child: CustomVerificationCodeWidget(
                        onComplete: (stringCode) {
                          _viewModel.setCode(stringCode);
                          _viewModel.verifyOtp();

                        },
                      ),
                    ),
                    const SizedBox(
                      height: AppSize.s20,
                    ),
                    Align(
                        key: globalKey,
                        alignment: FractionalOffset.bottomCenter,
                        child: Text(
                          AppStrings.sendOtpAgainHint.tr(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ))
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
