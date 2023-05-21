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
    return IconButton(
      onPressed: onPressed ?? () => Navigator.pop(context),
      icon: Icon(
        _appPrefs.getAppLanguage() == LanguageType.ENGLISH.getValue()
            ? Icons.keyboard_arrow_left
            : Icons.keyboard_arrow_right,
        color: ColorManager.black,
        size: 45,
      ),
    );
  }
}
