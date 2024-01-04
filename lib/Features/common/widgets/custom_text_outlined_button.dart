import 'package:flutter/material.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';
import 'package:taxi_for_you/core/utils/resources/styles_manager.dart';

class CustomTextOutlinedButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final double? height;
  final double? width;
  final double? fontSize;
  const CustomTextOutlinedButton({
    Key? key,
    this.backgroundColor,
    this.textColor,
    this.height,
    this.width,
    this.fontSize,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? ColorManager.accentColor,
          boxShadow: [
            BoxShadow(
              color: ColorManager.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 2),
            )
          ],
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        padding: const EdgeInsets.all(8),
        height: height ?? 55,
        width: width,
        child: Center(
          child: Text(
            text,
            style: getMediumStyle(
                color: textColor ?? ColorManager.primary,
                fontSize: fontSize ?? 18),
          ),
        ),
      ),
    );
  }
}
