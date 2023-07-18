import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';
import 'package:taxi_for_you/core/utils/resources/styles_manager.dart';

class CustomReloadWidget extends StatelessWidget {
  final Function onPressed;
  const CustomReloadWidget({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.refresh,
            color: ColorManager.primary,
            size: 40,
          ),
          const SizedBox(width: 8),
          Text(
            AppStrings.tapToReload.tr(),
            style: getBoldStyle(color: ColorManager.primary, fontSize: 16),
          )
        ],
      ),
    );
  }
}
