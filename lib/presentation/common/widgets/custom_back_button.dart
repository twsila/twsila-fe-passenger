import 'package:flutter/material.dart';

import '../../../utils/resources/color_manager.dart';

class CustomBackButton extends StatelessWidget {
  final Function() onPressed;
  final String? text;
  const CustomBackButton({Key? key, required this.onPressed, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          Align(
            alignment: Alignment.centerLeft,
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
          ),
          text != null
              ? Row(
                  children: [
                    const SizedBox(width: 16),
                    Text(
                      text!,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(fontSize: 24, color: ColorManager.black),
                    )
                  ],
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
