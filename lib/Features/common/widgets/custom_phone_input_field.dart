import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/common/state_renderer/dialogs.dart';
import 'dart:ui' as ui;
import 'package:taxi_for_you/Features/common/widgets/custom_bottom_sheet.dart';
import 'package:taxi_for_you/Features/common/widgets/custom_flag_widget.dart';
import 'package:taxi_for_you/Features/common/widgets/custom_text_input_field.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';
import 'package:taxi_for_you/data/model/country.dart';

import '../../../app/app_prefs.dart';
import '../../../app/di.dart';
import '../../../core/utils/resources/strings_manager.dart';
import 'custom_country_codes.dart';

class CustomPhoneInputField extends StatefulWidget {
  final CountryModel? selectedCountry;
  final TextEditingController fieldController;
  final validations;
  final Color? fillColor;
  final double? borderRadius;
  final bool autoFocus;
  final Color? borderColor;
  final Function(CountryModel) onCountryChange;
  final String? labelText;
  final bool showCountryCodesBottomSheet;
  final String? hintText;
  final bool boxShadow;

  const CustomPhoneInputField(
      {Key? key,
      required this.fieldController,
      this.autoFocus = false,
      this.selectedCountry,
      this.validations,
      this.borderColor,
      this.fillColor,
      this.borderRadius,
      required this.onCountryChange,
      this.labelText,
      this.showCountryCodesBottomSheet = true,
      this.boxShadow = true,
      this.hintText})
      : super(key: key);

  @override
  _CustomPhoneInputFieldState createState() => _CustomPhoneInputFieldState();
}

class _CustomPhoneInputFieldState extends State<CustomPhoneInputField> {
  final appPreferences = instance<AppPreferences>();
  bool? autoFocus;
  List<CountryModel> countries = [];
  CountryModel? _selectedCountry;

  @override
  void initState() {
    countries = appPreferences.getCountries();
    autoFocus = widget.autoFocus;
    if (widget.selectedCountry != null) {
      _selectedCountry = widget.selectedCountry;
    } else {
      if (appPreferences.getUserSelectedCountry() != null) {
        _selectedCountry = appPreferences.getUserSelectedCountry();
      } else {
        autoFocus = false;
        // Future.delayed(
        //   Duration.zero,
        //   () => ShowDialogHelper.showErrorMessage(
        //     AppStrings.notSupportedCountry.tr(),
        //     context,
        //   ),
        // );
        _selectedCountry = countries[0];
      }
    }

    widget.onCountryChange(_selectedCountry!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CustomTextInputField(
              autoFocus: autoFocus ?? false,
              controller: widget.fieldController,
              hintText: AppStrings.phoneNumberHint.tr(),
              isTitleBold: false,
              boxShadow: widget.boxShadow,
              borderColor: widget.borderColor,
              borderRadius: widget.borderRadius,
              fillColor: widget.fillColor ?? Colors.white,
              keyboardType: TextInputType.number,
              isKeyboardDigitsOnly: true,
              validationMethod: widget.validations ??
                  (value) {
                    RegExp regex = RegExp(r'^[0-9]{6,}$');
                    if (value == null) {
                      return AppStrings.phoneError.tr();
                    }
                    if (value.isEmpty) {
                      return AppStrings.phoneError.tr();
                    } else if (!regex.hasMatch(value) || value.contains(' ')) {
                      return AppStrings.phoneError.tr();
                    } else {
                      return null;
                    }
                  },
            ),
          ),
          const SizedBox(width: 4),
          InkWell(
            onTap: widget.showCountryCodesBottomSheet
                ? () {
                    CustomBottomSheet.displayModalBottomSheetList(
                      context: context,
                      showCloseButton: false,
                      customWidget: CustomCoutnryCodesWidget(
                        countries: countries,
                        selectedCountry: _selectedCountry,
                        getCountryCode: (country) {
                          setState(() {
                            _selectedCountry = country;
                          });
                          widget.onCountryChange(country);
                        },
                      ),
                      maxChildSize: 1,
                      initialChildSize: countries.length < 2
                          ? 0.1
                          : countries.length < 6
                              ? 0.3
                              : 1,
                    );
                  }
                : null,
            child: Container(
              height: 49,
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ColorManager.lightGrey,
                borderRadius: const BorderRadius.all(Radius.circular(2)),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.withOpacity(0.5),
                //     spreadRadius: 2,
                //     blurRadius: 7,
                //     offset: const Offset(0, 2),
                //   )
                // ],
              ),
              child: _selectedCountry != null
                  ? Row(
                      children: [
                        CustomNetworkImage(
                          imageUrl: _selectedCountry!.imageURL,
                          isCircle: true,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          _selectedCountry!.countryCode,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        widget.showCountryCodesBottomSheet
                            ? const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black,
                              )
                            : const SizedBox(),
                      ],
                    )
                  : const Icon(Icons.arrow_drop_down, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
