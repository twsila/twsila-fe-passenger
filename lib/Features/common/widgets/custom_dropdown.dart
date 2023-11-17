import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/lookups/model/lookups_model.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/di.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';
import 'package:taxi_for_you/core/utils/resources/styles_manager.dart';

class CustomDropDown extends StatefulWidget {
  final String? title;
  final Function(LookupItem?) onChanged;
  final String? hintText;
  final IconData? iconData;
  final String? intialValue;
  final String lookupKey;
  final bool isValid;
  final String? errorMessage;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? hintTextColor;
  final bool? isTitleBold;

  CustomDropDown(
      {this.title,
      required this.onChanged,
      required this.lookupKey,
      this.isValid = true,
      this.intialValue,
      this.hintText,
      this.iconData,
      this.backgroundColor,
      this.errorMessage,
      this.textColor,
      this.borderColor,
      this.hintTextColor,
      this.isTitleBold = true});

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  final AppPreferences appPreferences = instance();
  bool _isInit = true;
  LookupItem? _selectedValue;
  List<LookupItem> items = [];

  @override
  void initState() {
    if (_isInit) {
      items = appPreferences.getLookupByKey(widget.lookupKey);
      if (widget.intialValue != null) {
        _selectedValue = appPreferences.getLookupIndex(
            widget.lookupKey, widget.intialValue!);
        Future.delayed(Duration.zero, () => widget.onChanged(_selectedValue));
      }

      _isInit = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        widget.title != null && widget.title != ''
            ? Text(widget.title ?? '',
                style: getMediumStyle(
                    color: ColorManager.titlesTextColor, fontSize: 14))
            : Container(),
        const SizedBox(height: 12),
        Wrap(
          runSpacing: 8,
          children: List.generate(
            items.length,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  _selectedValue = items[index];
                });
                widget.onChanged(_selectedValue);
              },
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: items[index] == _selectedValue
                      ? ColorManager.secondaryLightColor
                      : Colors.transparent,
                  border: Border.all(
                    color: ColorManager.lightPrimary,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Text(
                    items[index].value.replaceAll('_', ' '),
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: ColorManager.secondaryColor,
                          fontSize: 16,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Divider(color: ColorManager.darkGrey),
      ],
    );
  }
}
