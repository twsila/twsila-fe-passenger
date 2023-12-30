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
  final LookupItem? intialValue;
  final bool isValid;
  final String? errorMessage;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? hintTextColor;
  final bool? isTitleBold;
  final List<LookupItem> items;

  const CustomDropDown({
    Key? key,
    this.title,
    required this.onChanged,
    required this.items,
    this.isValid = true,
    this.intialValue,
    this.hintText,
    this.iconData,
    this.backgroundColor,
    this.errorMessage,
    this.textColor,
    this.borderColor,
    this.hintTextColor,
    this.isTitleBold = true,
  }) : super(key: key);

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  final AppPreferences appPreferences = instance();
  bool _isInit = true;
  LookupItem? _selectedValue;

  @override
  void initState() {
    if (_isInit) {
      if (widget.intialValue != null) {
        _selectedValue = widget.intialValue!;
      }

      _isInit = false;
    }
    super.initState();
  }

  bool isChecked(int index) {
    if (_selectedValue != null) {
      return widget.items[index].id == _selectedValue!.id;
    }
    return false;
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
            widget.items.length,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  _selectedValue = widget.items[index];
                });
                widget.onChanged(_selectedValue);
              },
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: isChecked(index)
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
                    widget.items[index].value,
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
