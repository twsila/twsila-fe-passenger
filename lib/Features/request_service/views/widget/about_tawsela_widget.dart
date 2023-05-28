import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/core/utils/resources/assets_manager.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';

import '../../../../core/utils/resources/color_manager.dart';
import '../../../../core/utils/resources/styles_manager.dart';

class AboutTawsela extends StatefulWidget {
  @override
  _AboutTawselaState createState() => _AboutTawselaState();
}

class _AboutTawselaState extends State<AboutTawsela> {
  bool dismiss = false;
  @override
  Widget build(BuildContext context) {
    return dismiss
        ? const SizedBox()
        : Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
                color: Color.fromRGBO(239, 239, 254, 1),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.welcomeTo.tr() +
                          ' ' +
                          AppStrings.appTitle.tr(),
                      style: getMediumStyle(
                        color: ColorManager.primaryTextColor.withOpacity(0.5),
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                        onTap: () => setState(() {
                              dismiss = true;
                            }),
                        child: Image.asset(ImageAssets.cancelPurple))
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        AppStrings.whatIsTawsela.tr(),
                        style: getBoldStyle(
                          color: ColorManager.primaryTextColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Image.asset(ImageAssets.how)),
                    )
                  ],
                )
              ],
            ),
          );
  }
}
