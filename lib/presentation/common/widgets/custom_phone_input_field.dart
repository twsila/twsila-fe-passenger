import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/di.dart';
import 'package:taxi_for_you/presentation/login/login_viewmodel.dart';

import '../../../utils/resources/color_manager.dart';
import '../../../utils/resources/strings_manager.dart';
import '../../../utils/resources/styles_manager.dart';
import '../../../utils/resources/values_manager.dart';

class CustomPhoneInputField extends StatefulWidget {
  final LoginViewModel loginViewModel;
  final Function(Country)? onCountryChanged;
  final Function(PhoneNumber)? onChanged;
  final bool enabled;
  const CustomPhoneInputField({
    Key? key,
    required this.loginViewModel,
    this.onCountryChanged,
    this.onChanged,
    this.enabled = true,
  }) : super(key: key);

  @override
  State<CustomPhoneInputField> createState() => _CustomPhoneInputFieldState();
}

class _CustomPhoneInputFieldState extends State<CustomPhoneInputField> {
  final appPreferences = instance<AppPreferences>();

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      enabled: widget.enabled,
      decoration: InputDecoration(
        labelText: AppStrings.phoneNumberHint.tr(),
        labelStyle: getRegularStyle(
            color: ColorManager.lightGrey, fontSize: AppSize.s14),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.lightGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.lightGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.lightGrey),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.lightGrey),
        ),
      ),
      initialCountryCode: widget.loginViewModel.initialCountry,
      countries: const ['SA', 'EG'],
      flagsButtonPadding: const EdgeInsets.only(left: 16),
      initialValue: widget.loginViewModel.loginObject.phoneNumber,
      onCountryChanged: (country) {
        if (widget.onCountryChanged != null) widget.onCountryChanged!(country);
      },
      onChanged: (value) {
        if (widget.onChanged != null) widget.onChanged!(value);
      },
    );
  }
}
