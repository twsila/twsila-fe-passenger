import 'package:flutter/material.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/di.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';
import 'dart:math' as math;

import '../../../core/utils/resources/langauge_manager.dart';

class CustomTextButton extends StatefulWidget {
  final Function()? onPressed;
  final String text;
  final Color? color;
  final Color? textColor;
  final double? height;
  final double? fontSize;
  final bool? hasBorder;
  final bool showIcon;
  final bool showShadow;
  final IconData? iconData;
  final String? imageData;
  const CustomTextButton({
    Key? key,
    this.color,
    this.height,
    this.onPressed,
    this.hasBorder = false,
    this.showIcon = true,
    this.showShadow = true,
    this.textColor,
    this.fontSize,
    this.iconData,
    this.imageData,
    required this.text,
  }) : super(key: key);

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  final AppPreferences appPreferences = instance();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: widget.height ?? 50,
      decoration: BoxDecoration(
        border: widget.hasBorder!
            ? Border.all(color: ColorManager.primaryTextColor, width: 0.5)
            : null,
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        boxShadow: widget.onPressed == null || !widget.showShadow
            ? []
            : [
                BoxShadow(
                  color: ColorManager.primary.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                )
              ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.color ?? ColorManager.primary,
        ),
        onPressed: widget.onPressed,
        child: widget.showIcon
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.text,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: widget.textColor ?? Colors.white,
                          fontSize: widget.fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(width: 4),
                  widget.imageData != null
                      ? Image.asset(widget.imageData!)
                      : widget.iconData != null
                          ? Icon(
                              widget.iconData,
                              color: Colors.white,
                            )
                          : Transform.rotate(
                              angle: appPreferences.getAppLanguage() ==
                                      LanguageType.ENGLISH.getValue()
                                  ? 0
                                  : math.pi,
                              child: const Icon(
                                Icons.arrow_right_alt,
                                color: Colors.white,
                              ),
                            )
                ],
              )
            : Text(
                widget.text,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: widget.textColor ?? Colors.white,
                      fontSize: widget.fontSize,
                      fontWeight: FontWeight.bold,
                    ),
              ),
      ),
    );
  }
}
