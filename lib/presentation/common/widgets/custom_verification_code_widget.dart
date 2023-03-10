import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../../utils/resources/color_manager.dart';

class CustomVerificationCodeWidget extends StatefulWidget {
  Function(String) onComplete;

  CustomVerificationCodeWidget({Key? key, required this.onComplete})
      : super(key: key);

  @override
  State<CustomVerificationCodeWidget> createState() =>
      _CustomVerificationCodeWidgetState();
}

class _CustomVerificationCodeWidgetState
    extends State<CustomVerificationCodeWidget> {
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      margin: const EdgeInsets.all(5),
      textStyle: TextStyle(
          fontSize: 20,
          color: ColorManager.primary,
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: ColorManager.grey),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: ColorManager.black),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(color: ColorManager.grey),
      ),
    );
    return Pinput(
      length: 6,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      showCursor: true,
      onCompleted: widget.onComplete,
    );
  }
}
