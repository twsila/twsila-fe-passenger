import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/di.dart';
import 'package:taxi_for_you/Features/login/login_viewmodel.dart';

import '../../../core/utils/resources/color_manager.dart';
import '../../../core/utils/resources/strings_manager.dart';
import '../../../core/utils/resources/styles_manager.dart';

class CustomPhoneInputField extends StatefulWidget {
  final Function(Country)? onCountryChanged;
  final Function(PhoneNumber)? onChanged;
  final String? initialValue;
  final String? initialCountryCode;
  final bool enabled;
  const CustomPhoneInputField({
    Key? key,
    this.initialValue,
    this.initialCountryCode,
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
        labelStyle:
            getRegularStyle(color: ColorManager.lightGrey, fontSize: 14),
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
      initialCountryCode: widget.initialCountryCode,
      countries: const ['SA', 'EG'],
      flagsButtonPadding: const EdgeInsets.only(left: 16),
      initialValue: widget.initialValue,
      onCountryChanged: (country) {
        if (widget.onCountryChanged != null) widget.onCountryChanged!(country);
      },
      onChanged: (value) {
        if (widget.onChanged != null) widget.onChanged!(value);
      },
    );
  }
}
