import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/common/widgets/custom_scaffold.dart';
import 'package:taxi_for_you/Features/common/widgets/page_builder.dart';
import 'package:taxi_for_you/Features/otp/view/verify_otp_viewmodel.dart';
import 'package:taxi_for_you/core/utils/resources/langauge_manager.dart';

import '../../../app/app_prefs.dart';
import '../../../app/di.dart';
import '../../../core/utils/helpers/number_helper.dart';
import '../../../core/utils/resources/color_manager.dart';
import '../../../core/utils/resources/strings_manager.dart';
import '../../common/widgets/custom_countdown_timer.dart';
import '../../common/widgets/custom_verification_code_widget.dart';

class VerifyOtpScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  VerifyOtpScreen({Key? key}) : super(key: key);

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isInit = true;
  bool timeFinished = false;
  VerifyOTPViewModel _viewModel = VerifyOTPViewModel();
  GlobalKey globalKey = GlobalKey();

  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void dispose() {
    _viewModel.disponse();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _viewModel.mobileNumber =
          ModalRoute.of(context)!.settings.arguments as String;
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      pageBuilder: PageBuilder(
        scaffoldKey: widget.scaffoldKey,
        context: context,
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.enterVerificationCode.tr(),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: ColorManager.black, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 16),
                Text(
                  AppStrings.enterCodeHere.tr(),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: ColorManager.grey,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  _appPreferences.getAppLanguage() ==
                          LanguageType.ARABIC.getValue()
                      ? LanguageNumbersHelper()
                          .replaceArabicNumber(_viewModel.mobileNumber)
                      : _viewModel.mobileNumber,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: ColorManager.black, fontWeight: FontWeight.w500),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 32),
                  child: CustomVerificationCodeWidget(
                    controller: _viewModel.mobileController,
                    onCodeSubmitted: (code) {},
                    onCodeChanged: (code) {},
                  ),
                ),
                !timeFinished
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.codeArrive.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    color: ColorManager.black,
                                    fontWeight: FontWeight.w600),
                          ),
                          CustomCountDownTimer(
                            onTimerFinished: () {
                              setState(() {
                                timeFinished = true;
                              });
                            },
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                Icon(
                                  Icons.replay_outlined,
                                  color: ColorManager.primary,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  AppStrings.codeDidntArrive.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                          color: ColorManager.primary,
                                          fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
