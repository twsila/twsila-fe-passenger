import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';
import 'package:taxi_for_you/core/utils/resources/validations_manager.dart';

import 'decorated_border.dart';

class CustomTextInputField extends StatefulWidget {
  final FormFieldValidator<String>? validationMethod;
  final String? hintText;
  final Color? textColor;
  final Color? hintTextColor;
  final String? errorLabel;
  final TextInputAction textInputAction;
  final VoidCallback? onEditingComplete;
  final FocusNode? focusNode;
  final Key? basicInputKey;
  final TextEditingController? controller;
  final bool? isRequired;
  final Function(String)? onChanged;
  final String? semanticsLabelKey;
  final String? errorLabelKey;
  final bool enabled;
  final Widget? icon;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxLength;
  final TextAlign? textAlign;
  final bool validateEmptyString;
  final bool validateZeroNumber;
  final bool clearIcon;
  final double? borderRadius;
  final Color? borderColor;
  final Color? clearIconColor;
  final bool isKeyboardDigitsOnly;
  final List<TextInputFormatter>? inputFormatter;
  final bool obscureText;
  final bool showLabelText;
  final String? labelText;
  final Color fillColor;
  final String? helperText;
  final String? customSpecialCharachterMessage;
  final Function(String)? onFieldSubmitted;
  final VoidCallback? onClearIconTapped;
  final bool validateSpecialCharacter;
  final bool isCharacterOnly;
  final bool autoFocus;
  final bool checkMinimumCharacter;
  final int minimumNumberOfCharacters;
  final bool validateEmail;
  final bool isDimmed;
  final Function? shouldRequestFocus;
  final Function(String?)? onSaved;
  final Color? backgroundColor;
  final bool? isTitleBold;
  final bool boxShadow;

  // final String? key;

  CustomTextInputField({
    this.enabled = true,
    this.isDimmed = false,
    this.isRequired = false,
    this.autoFocus = false,
    this.textColor,
    this.hintTextColor,
    this.obscureText = false,
    this.isKeyboardDigitsOnly = false,
    // this.initialValue = "",
    this.isCharacterOnly = false,
    this.prefixIcon,
    this.clearIcon = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.validationMethod,
    this.icon,
    this.hintText = '',
    this.backgroundColor,
    this.errorLabel,
    this.textInputAction = TextInputAction.next,
    this.onEditingComplete,
    this.basicInputKey,
    this.controller,
    this.onChanged,
    this.focusNode,
    this.semanticsLabelKey,
    this.errorLabelKey,
    Key? key,
    this.maxLength,
    this.textAlign,
    this.inputFormatter,
    this.validateEmptyString = false,
    this.borderRadius,
    this.borderColor,
    this.validateZeroNumber = false,
    this.showLabelText = false,
    this.labelText,
    this.fillColor = Colors.white,
    this.helperText,
    this.onFieldSubmitted,
    this.onClearIconTapped,
    this.validateSpecialCharacter = false,
    this.customSpecialCharachterMessage,
    this.checkMinimumCharacter = false,
    this.validateEmail = false,
    this.shouldRequestFocus,
    this.minimumNumberOfCharacters = 0,
    this.onSaved,
    this.isTitleBold = true,
    this.clearIconColor,
    this.boxShadow = false,
  }) : super(key: key);

  @override
  _CustomTextInputFieldState createState() => new _CustomTextInputFieldState();
}

class _CustomTextInputFieldState extends State<CustomTextInputField> {
  FocusNode? _myFocusNode;
  Key? _basicInputKey;
  TextEditingController? _textController;

  @override
  void initState() {
    _basicInputKey = (widget.basicInputKey == null)
        ? Key('basic_input')
        : widget.basicInputKey;
    _myFocusNode = (widget.focusNode == null) ? FocusNode() : widget.focusNode;
    _textController = (widget.controller == null)
        ? TextEditingController()
        : widget.controller;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.showLabelText
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(widget.labelText!,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: widget.isTitleBold!
                                ? FontWeight.bold
                                : FontWeight.normal,
                          )),
                  if (widget.isRequired!)
                    Text(
                      '*',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.red),
                    )
                ],
              ),
              const SizedBox(height: 8),
              _textFormField(),
            ],
          )
        : _textFormField();
  }

  _textFormField() {
    return Semantics(
      label: widget.semanticsLabelKey,
      child: TextFormField(
        autofocus: widget.autoFocus,
        style: Theme.of(context)
            .textTheme
            .labelLarge!
            .copyWith(color: widget.textColor ?? Colors.black),
        obscureText: widget.obscureText,
        textAlign: widget.textAlign ?? TextAlign.start,
        maxLength: widget.maxLength,
        cursorColor: widget.hintTextColor ?? ColorManager.hintTextColor,
        key: _basicInputKey,
        textInputAction: widget.textInputAction,
        enabled: widget.enabled,
        focusNode: _myFocusNode,
        controller: _textController,
        keyboardType: widget.keyboardType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        autocorrect: false,
        onFieldSubmitted: widget.onFieldSubmitted,
        validator: (val) {
          if (widget.validateEmail) {
            if (!AppValidations.isEmailValid(val!)) {
              if (widget.shouldRequestFocus!()) _myFocusNode!.requestFocus();
              return AppStrings.invalidEmail.tr();
            }
          }
          if (val == null || (widget.validateEmptyString && val.isEmpty)) {
            if (widget.shouldRequestFocus != null &&
                widget.shouldRequestFocus!()) _myFocusNode!.requestFocus();
            return AppStrings.errorField.tr() +
                (widget.errorLabel ?? AppStrings.validField.tr());
          }

          if (widget.checkMinimumCharacter) {
            if (widget.shouldRequestFocus != null &&
                widget.shouldRequestFocus!()) _myFocusNode!.requestFocus();

            return val.length < widget.minimumNumberOfCharacters
                ? AppStrings.errorField.tr() +
                    (widget.errorLabel ?? AppStrings.validField.tr())
                : null;
          }
          if (widget.validateEmptyString &&
              (val.isEmpty || val.trim().isEmpty)) {
            widget.shouldRequestFocus != null
                ? widget.shouldRequestFocus!()
                    ? _myFocusNode!.requestFocus()
                    : 0
                : 0;
            return AppStrings.errorField.tr() +
                (widget.errorLabel ?? AppStrings.validField.tr());
          } else if (widget.validateZeroNumber &&
              widget.keyboardType.index == 2 &&
              AppValidations.checkIFAllZero(val)) {
            widget.shouldRequestFocus != null
                ? widget.shouldRequestFocus!()
                    ? _myFocusNode!.requestFocus()
                    : 0
                : 0;
            return AppStrings.noZero.tr();
          }
          //will check for validation method lastly
          if (widget.validationMethod != null) {
            return widget.validationMethod!(val);
          }
          if (widget.isCharacterOnly == true) {
            widget.shouldRequestFocus != null
                ? widget.shouldRequestFocus!()
                    ? _myFocusNode!.requestFocus()
                    : 0
                : 0;
            return RegExp(
              r"^[a-zA-Z]+$",
            ).hasMatch(val)
                ? null
                : widget.customSpecialCharachterMessage ??
                    AppStrings.errorField.tr() +
                        (widget.errorLabel ?? AppStrings.validField.tr());
          }
          if (widget.validateSpecialCharacter == true) {
            widget.shouldRequestFocus != null
                ? widget.shouldRequestFocus!()
                    ? _myFocusNode!.requestFocus()
                    : 0
                : 0;
            return RegExp(r"^[a-zA-Z0-9]+$").hasMatch(val)
                ? null
                : widget.customSpecialCharachterMessage ??
                    AppStrings.errorField.tr() +
                        (widget.errorLabel ?? AppStrings.validField.tr());
          }
          return null;
        },
        inputFormatters: widget.inputFormatter ??
            <TextInputFormatter>[
              if (widget.isKeyboardDigitsOnly)
                FilteringTextInputFormatter.digitsOnly
            ],
        // Only numbers
        decoration: InputDecoration(
          fillColor:
              widget.enabled ? widget.fillColor : ColorManager.accentColor,
          filled: true,
          errorMaxLines: 8,
          helperMaxLines: 8,
          helperText: widget.helperText,
          contentPadding: const EdgeInsets.all(10),
          counterStyle: const TextStyle(
            height: double.minPositive,
          ),
          counterText: "",
          prefixIcon: widget.prefixIcon,
          suffixIcon: (widget.clearIcon)
              ? Padding(
                  padding: const EdgeInsetsDirectional.all(14),
                  child: GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black, width: 1.5),
                      ),
                      child: const Icon(
                        Icons.clear_rounded,
                        color: Colors.black,
                        size: 13.0,
                      ),
                    ),
                    onTap: () {
                      if (widget.onClearIconTapped != null) {
                        widget.onClearIconTapped!();
                      } else {
                        setState(() {
                          widget.controller!.clear();
                          if (widget.onChanged != null) widget.onChanged!("");
                        });
                      }
                    },
                  ),
                )
              : widget.suffixIcon != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [widget.suffixIcon!],
                    )
                  : null,
          errorStyle: const TextStyle(
            color: Colors.red,
          ),
          helperStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: ColorManager.grey,
              ),
          errorBorder: DecoratedInputBorder(
            child: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
              borderSide: const BorderSide(color: Colors.red),
            ),
            shadow: BoxShadow(
              color: Colors.grey.withOpacity(widget.boxShadow ? 0.5 : 0.0),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 2),
            ),
          ),
          focusedBorder: DecoratedInputBorder(
              child: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
                borderSide: BorderSide(
                  color: widget.borderColor ?? ColorManager.grey,
                ),
              ),
              shadow: BoxShadow(
                color: Colors.grey.withOpacity(widget.boxShadow ? 0.5 : 0.0),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 2),
              )),
          disabledBorder: DecoratedInputBorder(
              child: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
                borderSide: BorderSide(
                  color: widget.borderColor ?? ColorManager.hintTextColor,
                ),
              ),
              shadow: BoxShadow(
                color: Colors.grey.withOpacity(widget.boxShadow ? 0.5 : 0.0),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 2),
              )),
          focusedErrorBorder: DecoratedInputBorder(
              child: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
                borderSide: const BorderSide(color: Colors.red),
              ),
              shadow: BoxShadow(
                color: Colors.grey.withOpacity(widget.boxShadow ? 0.5 : 0.0),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 2),
              )),
          enabledBorder: DecoratedInputBorder(
              child: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
                borderSide: BorderSide(
                  color: widget.borderColor ?? ColorManager.grey,
                ),
              ),
              shadow: BoxShadow(
                color: Colors.grey.withOpacity(widget.boxShadow ? 0.5 : 0.0),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 2),
              )),
          hintText: widget.hintText,
          hintStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: widget.hintTextColor ?? ColorManager.grey, fontSize: 13),
          alignLabelWithHint: true,
        ),
        onChanged: (val) {
          if (widget.onChanged != null) widget.onChanged!(val);
        },
        onSaved: widget.onSaved,
      ),
    );
  }

  @override
  void dispose() {
    _myFocusNode?.dispose();
    super.dispose();
  }
}
