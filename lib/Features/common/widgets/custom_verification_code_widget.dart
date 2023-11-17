import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:taxi_for_you/Features/common/widgets/custom_showpin_button.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';

class CustomVerificationCodeWidget extends StatefulWidget {
  final TextEditingController controller;
  final int otpLength;
  final bool autoFocus;
  final Function(String) onCodeChanged;
  final Function(String) onCodeSubmitted;

  CustomVerificationCodeWidget({
    Key? key,
    required this.controller,
    required this.onCodeSubmitted,
    required this.onCodeChanged,
    this.autoFocus = true,
    this.otpLength = 6,
  }) : super(key: key);

  @override
  State<CustomVerificationCodeWidget> createState() =>
      _CustomVerificationCodeWidgetState();
}

class _CustomVerificationCodeWidgetState
    extends State<CustomVerificationCodeWidget> with CodeAutoFill {
  final _codeFocus = FocusNode();
  String codeValue = '';
  bool _isHidden = true;

  @override
  void codeUpdated() {
    setState(() {});
  }

  @override
  void initState() {
    listenOtp();
    super.initState();
  }

  @override
  void dispose() {
    _codeFocus.dispose();
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  void listenOtp() async {
    await SmsAutoFill().unregisterListener();
    listenForCode();
    SmsAutoFill().listenForCode;
  }

  KeyboardActionsConfig _buildKeyboardActionsConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      defaultDoneWidget:
          Text(AppStrings.verify.tr(), style: const TextStyle(fontSize: 8)),
      keyboardBarColor: ColorManager.lightGrey,
      actions: [
        KeyboardActionsItem(
          focusNode: _codeFocus,
          onTapAction: () {
            widget.onCodeSubmitted(codeValue);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          SizedBox(
            height: 55,
            child: KeyboardActions(
              config: _buildKeyboardActionsConfig(context),
              child: PinFieldAutoFill(
                focusNode: _codeFocus,
                decoration: BoxLooseDecoration(
                  bgColorBuilder: FixedColorBuilder(ColorManager.lightGrey),
                  obscureStyle: ObscureStyle(
                    isTextObscure: _isHidden,
                    obscureText: '⬤',
                  ),
                  textStyle: Theme.of(context).textTheme.labelLarge,
                  strokeColorBuilder:
                      const FixedColorBuilder(Colors.transparent),
                  radius: const Radius.circular(5),
                  strokeWidth: 2,
                  gapSpace: 5,
                ),
                autoFocus: widget.autoFocus,
                currentCode: codeValue,
                enableInteractiveSelection: false,
                controller: widget.controller,
                codeLength: widget.otpLength,
                onCodeSubmitted: (code) {
                  codeValue = code;
                  widget.onCodeSubmitted(code);
                },
                onCodeChanged: (code) {
                  setState(() {
                    codeValue = code.toString();
                    widget.onCodeChanged(codeValue);
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 24),
          CustomShowPinButton(onChanged: (isHidden) {
            setState(() {
              _isHidden = isHidden;
            });
          })
        ],
      ),
    );
  }
}
