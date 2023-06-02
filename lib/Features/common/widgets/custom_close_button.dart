import 'package:flutter/material.dart';
import 'package:taxi_for_you/core/utils/resources/assets_manager.dart';

class CustomCloseButton extends StatelessWidget {
  final Function()? onPressed;
  final String? text;
  const CustomCloseButton({Key? key, this.onPressed, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed ?? Navigator.pop(context),
      child: SizedBox(
        width: 24,
        height: 24,
        child: Image.asset(ImageAssets.cancelBlue),
      ),
    );
  }
}
