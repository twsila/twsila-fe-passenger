import 'package:flutter/material.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/di.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';
import 'package:taxi_for_you/core/utils/resources/styles_manager.dart';

import '../../../../../core/utils/resources/langauge_manager.dart';

class MenuWidget extends StatelessWidget {
  final AppPreferences appPreferences = instance();
  final String menuImage;
  final String menuLabel;
  final Function onPressed;

  MenuWidget({
    Key? key,
    required this.menuImage,
    required this.menuLabel,
    required this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Row(
        children: [
          SizedBox(
            height: 40,
            width: 40,
            child: Image.asset(menuImage),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    menuLabel,
                    style: getBoldStyle(
                      color: ColorManager.primaryTextColor,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Icon(
                  appPreferences.getAppLanguage() !=
                          LanguageType.ENGLISH.getValue()
                      ? Icons.keyboard_arrow_left
                      : Icons.keyboard_arrow_right,
                  color: ColorManager.black,
                  size: 45,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
