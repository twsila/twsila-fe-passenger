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
  final double? height;
  const CustomTextButton({
    Key? key,
    this.color,
    this.height,
    this.onPressed,
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
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        boxShadow: [
          BoxShadow(
            color: ColorManager.primary.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.text,
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Colors.white),
            ),
            const SizedBox(width: 4),
            Transform.rotate(
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
        ),
      ),
    );
  }
}
