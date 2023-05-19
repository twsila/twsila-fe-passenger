import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/Features/common/widgets/custom_phone_input_field.dart';
import 'package:taxi_for_you/core/utils/ext/screen_size_ext.dart';
import 'package:taxi_for_you/core/utils/location/map_provider.dart';

import '../../../app/di.dart';
import '../../../core/utils/resources/assets_manager.dart';
import '../../../core/utils/resources/strings_manager.dart';
import '../../common/widgets/custom_text_button.dart';
import '../login_viewmodel.dart';

class PhoneLoginView extends StatefulWidget {
  const PhoneLoginView({Key? key}) : super(key: key);

  @override
  State<PhoneLoginView> createState() => _PhoneLoginViewState();
}

class _PhoneLoginViewState extends State<PhoneLoginView> {
  final AppPreferences appPreferences = instance<AppPreferences>();
  final LoginViewModel _viewModel = instance<LoginViewModel>();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Center(child: Image(image: AssetImage(ImageAssets.logoImg))),
          const SizedBox(
            height: 28,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: context.getHeight() / 16),
            child: Column(
              children: [
                Text(
                  AppStrings.whatsYourNumber.tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  AppStrings.letsGetStarted.tr(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: context.getWidth() / 12),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomPhoneInputField(
                    onCountryChanged: (country) {
                      _viewModel.initialCountry = country.code;
                      appPreferences.setUserSelectedCountry(country.code);
                      Provider.of<MapProvider>(context, listen: false)
                          .setCountry(country.code);
                    },
                    onChanged: (value) {
                      _viewModel.setCountryCode(value.countryCode);
                      _viewModel.setPhoneNumber(value.number);
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
                        initVerifyOtpModule();
                        _viewModel.goNext();
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
