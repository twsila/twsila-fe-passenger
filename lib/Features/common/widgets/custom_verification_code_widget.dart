import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:taxi_for_you/Features/common/widgets/custom_showpin_button.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';

class CustomVerificationCodeWidget extends StatefulWidget {
  final TextEditingController controller;
  final int otpLength;
  final Function(String) onCodeChanged;
  final Function(String) onCodeSubmitted;

  CustomVerificationCodeWidget({
    Key? key,
    required this.controller,
    required this.onCodeSubmitted,
    required this.onCodeChanged,
    this.otpLength = 6,
  }) : super(key: key);

  @override
  State<CustomVerificationCodeWidget> createState() =>
      _CustomVerificationCodeWidgetState();
}

class _CustomVerificationCodeWidgetState
    extends State<CustomVerificationCodeWidget> with CodeAutoFill {
  String codeValue = '';
  bool _isHidden = true;

  @override
  void codeUpdated() {
    print("Update code $code");
    setState(() {
      print("codeUpdated");
    });
  }

  @override
  void initState() {
    listenOtp();
    super.initState();
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  void listenOtp() async {
    await SmsAutoFill().unregisterListener();
    listenForCode();
    SmsAutoFill().listenForCode;
    print("OTP listen Called");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          PinFieldAutoFill(
            decoration: BoxLooseDecoration(
              bgColorBuilder: FixedColorBuilder(ColorManager.lightGrey),
              obscureStyle: ObscureStyle(
                isTextObscure: _isHidden,
                obscureText: '⬤',
              ),
              textStyle: Theme.of(context).textTheme.labelLarge,
              strokeColorBuilder: const FixedColorBuilder(Colors.transparent),
              radius: const Radius.circular(5),
              strokeWidth: 2,
              gapSpace: 5,
            ),
            autoFocus: true,
            currentCode: codeValue,
            enableInteractiveSelection: false,
            controller: widget.controller,
            codeLength: widget.otpLength,
            onCodeSubmitted: (code) {
              print("onCodeSubmitted $code");
            },
            onCodeChanged: (code) {
              print("onCodeChanged $code");
              setState(() {
                codeValue = code.toString();
                widget.onCodeChanged(codeValue);
              });
            },
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
