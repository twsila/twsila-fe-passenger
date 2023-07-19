import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/core/utils/resources/assets_manager.dart';

import '../../../../../core/utils/resources/color_manager.dart';
import '../../../../../core/utils/resources/strings_manager.dart';
import '../../../../common/widgets/custom_text_button.dart';

class NeedHelpButton extends StatefulWidget {
  final int tripId;
  const NeedHelpButton({Key? key, required this.tripId}) : super(key: key);

  @override
  State<NeedHelpButton> createState() => _NeedHelpButtonState();
}

class _NeedHelpButtonState extends State<NeedHelpButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: CustomTextButton(
        text: AppStrings.needHelp.tr(),
        showIcon: true,
        imageData: ImageAssets.logo,
        showShadow: false,
        hasBorder: true,
        color: ColorManager.white,
        textColor: ColorManager.primaryTextColor,
        onPressed: () {},
      ),
    );
  }
}
