import 'package:flutter/material.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';

class CustomDropDown extends StatefulWidget {
  final String? title;
  final List<String>? stringsArr;
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
      required this.isValid,
      required this.onChanged,
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

  @override
  void initState() {
    if (_isInit) {
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
            ? Text(
                widget.title ?? '',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight:
                      widget.isTitleBold! ? FontWeight.bold : FontWeight.normal,
                  fontFamily: 'Avenir',
                  color: Colors.black,
                ),
              )
            : Container(),
        Container(
          height: 45,
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: widget.isValid
                ? Border.all(
                    color: widget.borderColor ?? ColorManager.lightPrimary)
                : Border.all(color: Colors.red),
          ),
          child: Row(
            children: [
              if (widget.iconData != null)
                Container(
                    margin: const EdgeInsets.only(left: 16),
                    child: Icon(
                      Icons.male,
                      color: ColorManager.lightGrey,
                    )),
              Expanded(
                child: Theme(
                  data: ThemeData(canvasColor: Colors.white),
                  child: DropdownButtonHideUnderline(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<String>(
                        value: widget.intialValue,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: widget.borderColor ?? ColorManager.primary,
                        ),
                        style: Theme.of(context).textTheme.displayMedium,
                        hint: widget.hintText != null
                            ? Text(
                                widget.hintText!,
                                style: Theme.of(context).textTheme.displaySmall,
                              )
                            : null,
                        onChanged: (String? selectedValue) {
                          setState(() {
                            FocusScope.of(context).requestFocus(FocusNode());
                            widget.onChanged(selectedValue);
                          });
                        },
                        items: widget.stringsArr!.map((String date) {
                          return DropdownMenuItem<String>(
                            value: date,
                            child: Text(
                              date,
                              style: TextStyle(
                                color: widget.textColor ??
                                    Theme.of(context).primaryColor,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        !widget.isValid
            ? Text(
                widget.errorMessage ?? '',
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: Colors.red),
              )
            : Container()
      ],
    );
  }
}
