import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/di.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';

import 'custom_text_input_field.dart';

class CustomPaymentField extends StatefulWidget {
  Function(String?) onChanged;
  CustomPaymentField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<CustomPaymentField> createState() => _CustomPaymentFieldState();
}

class _CustomPaymentFieldState extends State<CustomPaymentField> {
  final _appPrefs = instance<AppPreferences>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text(
              AppStrings.iWantToPay.tr(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: 45,
              child: CustomTextInputField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  widget.onChanged(value);
                },
              ),
            ),
            Text(
              _appPrefs.getCurrentCurrnecy(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        Text(
          AppStrings.paymentNote.tr(),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
