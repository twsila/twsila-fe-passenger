import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/presentation/common/widgets/custom_phone_input_field.dart';
import 'package:taxi_for_you/utils/ext/screen_size_ext.dart';
import 'package:taxi_for_you/utils/location/map_provider.dart';
import 'package:taxi_for_you/utils/resources/styles_manager.dart';

import '../../../app/di.dart';
import '../../../utils/resources/assets_manager.dart';
import '../../../utils/resources/color_manager.dart';
import '../../../utils/resources/strings_manager.dart';
import '../../../utils/resources/values_manager.dart';
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
            height: AppSize.s28,
          ),
          Container(
            margin: EdgeInsets.symmetric(
                vertical: context.getHeight() / AppSize.s16),
            child: Column(
              children: [
                Text(
                  AppStrings.whatsYourNumber.tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: AppSize.s4),
                Text(
                  AppStrings.letsGetStarted.tr(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: context.getWidth() / AppSize.s12),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomPhoneInputField(
                    loginViewModel: _viewModel,
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
                    height: AppSize.s28,
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
