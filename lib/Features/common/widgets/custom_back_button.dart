import 'package:flutter/material.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/di.dart';

import '../../../core/utils/resources/color_manager.dart';
import '../../../core/utils/resources/langauge_manager.dart';

class CustomBackButton extends StatelessWidget {
  final _appPrefs = instance<AppPreferences>();
  final Function()? onPressed;
  final String? text;
  CustomBackButton({Key? key, this.onPressed, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ?? () => Navigator.pop(context),
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
                  _appPrefs.getAppLanguage() == LanguageType.ENGLISH.getValue()
                      ? Icons.keyboard_arrow_left
                      : Icons.keyboard_arrow_right,
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
