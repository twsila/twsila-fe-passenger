import 'package:flutter/material.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';
import 'package:taxi_for_you/core/utils/resources/styles_manager.dart';

class CustomDropDown extends StatefulWidget {
  final String? title;
  final List<String> stringsArr;
  final Function(String?) onChanged;
  final String? hintText;
  final IconData? iconData;
  final String? intialValue;
  final bool isValid;
  final String? errorMessage;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? hintTextColor;
  final bool? isTitleBold;

  CustomDropDown(
      {this.title,
      required this.stringsArr,
      required this.onChanged,
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
  bool _isInit = true;
  String? _selectedValue;

  @override
  void initState() {
    if (_isInit) {
      _selectedValue = widget.intialValue;
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
            widget.stringsArr.length,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  _selectedValue = widget.stringsArr[index];
                });
                widget.onChanged(_selectedValue);
              },
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: widget.stringsArr[index] == _selectedValue
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
                    widget.stringsArr[index],
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
