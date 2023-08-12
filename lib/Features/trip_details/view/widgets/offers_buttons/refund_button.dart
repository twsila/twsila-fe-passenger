import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';

import '../../../../../core/utils/resources/strings_manager.dart';
import '../../../../common/widgets/custom_text_button.dart';

class RefundButton extends StatelessWidget {
  final int tripId;
  const RefundButton({Key? key, required this.tripId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomTextButton(
      text: AppStrings.refundAmount.tr(),
      showIcon: true,
      iconData: Icons.refresh,
      color: ColorManager.accentColor,
      fontSize: 12,
      textColor: ColorManager.primary,
      iconColor: ColorManager.primary,
      showShadow: false,
      onPressed: () {},
    );
  }
}
