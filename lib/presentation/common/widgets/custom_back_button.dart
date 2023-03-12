import 'package:flutter/material.dart';

import '../../../utils/resources/color_manager.dart';

class CustomBackButton extends StatelessWidget {
  final Function() onPressed;
  const CustomBackButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Icon(
            Icons.keyboard_arrow_left,
            color: ColorManager.white,
          )),
    );
  }
}
