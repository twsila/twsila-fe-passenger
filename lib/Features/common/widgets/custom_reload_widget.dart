import 'package:flutter/material.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';

class CustomReloadWidget extends StatelessWidget {
  final Function onPressed;
  const CustomReloadWidget({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Center(
        child: Icon(
          Icons.refresh,
          color: ColorManager.primary,
          size: 40,
        ),
      ),
    );
  }
}
