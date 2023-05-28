import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/di.dart';
import 'package:taxi_for_you/core/utils/resources/assets_manager.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';
import 'package:taxi_for_you/core/utils/resources/styles_manager.dart';

import '../../../../data/model/user-model.dart';

class CustomProfileWidget extends StatefulWidget {
  @override
  _CustomProfileWidgetState createState() => _CustomProfileWidgetState();
}

class _CustomProfileWidgetState extends State<CustomProfileWidget> {
  AppPreferences appPreferences = instance<AppPreferences>();
  late UserModel userModel;

  @override
  void initState() {
    UserModel? user = appPreferences.getUserData();
    if (user != null) {
      userModel = user;
    } else {
      appPreferences.logout(context);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      height: 80,
      child: Row(
        children: [
          Container(
            width: 80,
            decoration: BoxDecoration(
                color: ColorManager.bottomNavUnselected,
                borderRadius: const BorderRadius.all(Radius.circular(8))),
            child: Image.asset(ImageAssets.userProfile),
          ),
          const SizedBox(width: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (userModel.firstName ?? '') + ' ' + (userModel.lastName ?? ''),
                style: getBoldStyle(
                    color: ColorManager.primaryTextColor, fontSize: 14),
              ),
              Text(
                (userModel.mobileNumber ?? ''),
                style: getBoldStyle(
                    color: ColorManager.bottomNavUnselected, fontSize: 14),
              ),
              Row(
                children: [
                  Text(
                    AppStrings.editProfile.tr(),
                    style:
                        getBoldStyle(color: ColorManager.primary, fontSize: 14),
                  ),
                  const SizedBox(width: 4),
                  Image.asset(ImageAssets.edit),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
