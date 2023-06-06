import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/di.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';
import 'package:taxi_for_you/core/utils/resources/styles_manager.dart';

import 'custom_text_input_field.dart';

class CustomAmountField extends StatefulWidget {
  final Function(String?) onChanged;
  final TextEditingController controller;
  const CustomAmountField({
    Key? key,
    required this.onChanged,
    required this.controller,
  }) : super(key: key);

  @override
  State<CustomAmountField> createState() => _CustomAmountFieldState();
}

class _CustomAmountFieldState extends State<CustomAmountField> {
  final _appPrefs = instance<AppPreferences>();

  @override
  Widget build(BuildContext context) {
    return CustomTextInputField(
      controller: widget.controller,
      keyboardType: TextInputType.number,
      labelText: AppStrings.iWantToPay.tr(),
      showLabelText: true,
      hintText: AppStrings.enterAmount.tr(),
      suffixIcon: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          _appPrefs.getUserSelectedCountry()!.country == "SA"
              ? AppStrings.saudiCurrency.tr()
              : AppStrings.egpCurrency.tr(),
          style: getMediumStyle(color: Colors.black, fontSize: 12),
        ),
      ),
      onChanged: (text) {
        widget.onChanged(text);
      },
    );
  }
}
