import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi_for_you/Features/common/widgets/custom_scaffold.dart';
import 'package:taxi_for_you/Features/common/widgets/page_builder.dart';
import 'package:taxi_for_you/core/utils/ext/screen_size_ext.dart';
import 'dart:ui' as ui;

import '../../../app/app_prefs.dart';
import '../../../app/di.dart';
import '../../../core/utils/location/map_provider.dart';
import '../../../core/utils/resources/assets_manager.dart';
import '../../../core/utils/resources/color_manager.dart';
import '../../../core/utils/resources/routes_manager.dart';
import '../../../core/utils/resources/strings_manager.dart';
import '../../common/widgets/custom_language_widget.dart';
import '../../common/widgets/custom_phone_input_field.dart';
import '../../common/widgets/custom_text_button.dart';
import 'login_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginViewModel _viewModel = instance<LoginViewModel>();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      pageBuilder: PageBuilder(
        scaffoldKey: widget.scaffoldKey,
        allowBackButtonInAppBar: false,
        context: context,
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Directionality(
                  textDirection: ui.TextDirection.rtl,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const LanguageWidget(),
                      Center(
                        child: Image(
                          image: const AssetImage(ImageAssets.logoImg),
                          height: 28,
                          width: context.getWidth() / 4,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: context.getHeight() / 16),
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
                        AppStrings.enterPhoneNumber.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: ColorManager.black,
                                fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 32),
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomPhoneInputField(
                              borderRadius: 2,
                              autoFocus: true,
                              borderColor: Colors.transparent,
                              fillColor: ColorManager.accentColor,
                              boxShadow: false,
                              fieldController: _viewModel.phoneController,
                              onCountryChange: (country) {
                                _viewModel.countryCode = country.countryCode;
                                Provider.of<MapProvider>(context, listen: false)
                                    .setCountry(country, needsRebuild: false);
                              },
                            ),
                            const SizedBox(
                              height: 28,
                            ),
                            CustomTextButton(
                              text: AppStrings.continueBtn.tr(),
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                if (_formKey.currentState != null &&
                                    _formKey.currentState!.validate()) {
                                  String mobileNumber = _viewModel.countryCode +
                                      _viewModel.phoneController.text;
                                  Navigator.pushNamed(
                                    context,
                                    Routes.verifyOtpRoute,
                                    arguments: mobileNumber,
                                  );
                                }
                              },
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
        ),
      ),
    );
  }
}
