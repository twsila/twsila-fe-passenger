import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/core/utils/ext/screen_size_ext.dart';
import 'package:taxi_for_you/core/utils/resources/assets_manager.dart';

import '../../../../../core/utils/resources/color_manager.dart';
import '../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../core/utils/resources/styles_manager.dart';
import '../../../../common/widgets/custom_text_button.dart';

class DriversListWidget extends StatefulWidget {
  const DriversListWidget({Key? key}) : super(key: key);

  @override
  State<DriversListWidget> createState() => _DriversListWidgetState();
}

class _DriversListWidgetState extends State<DriversListWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: context.getHeight() / 3,
          child: Image.asset(ImageAssets.driverWaiting),
        ),
        Text(
          'في انتظار العروض من السائقين',
          style: getBoldStyle(
            color: ColorManager.black,
            fontSize: 18,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          child: CustomTextButton(
            text: AppStrings.cancel.tr() + ' ' + AppStrings.request.tr(),
            showIcon: false,
            showShadow: false,
            hasBorder: true,
            color: ColorManager.white,
            textColor: ColorManager.primaryTextColor,
            onPressed: () {},
          ),
        )
      ],
    );
  }
}
