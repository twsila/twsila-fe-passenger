import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_prefs.dart';
import '../../../../app/di.dart';
import '../../../../core/utils/helpers/number_helper.dart';
import '../../../../core/utils/resources/color_manager.dart';
import '../../../../core/utils/resources/langauge_manager.dart';
import '../../../../core/utils/resources/strings_manager.dart';

class CustomOtpTextWidget extends StatelessWidget {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final String mobileNumber;
  CustomOtpTextWidget({Key? key, required this.mobileNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.enterVerificationCode.tr(),
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: ColorManager.black, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 16),
        Text(
          AppStrings.enterCodeHere.tr(),
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: ColorManager.grey,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          _appPreferences.getAppLanguage() == LanguageType.ARABIC.getValue()
              ? LanguageNumbersHelper().replaceArabicNumber(mobileNumber)
              : mobileNumber,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: ColorManager.black, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
