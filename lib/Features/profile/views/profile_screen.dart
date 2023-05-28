import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/common/widgets/custom_scaffold.dart';
import 'package:taxi_for_you/Features/common/widgets/page_builder.dart';
import 'package:taxi_for_you/Features/profile/views/widgets/menu_widget.dart';
import 'package:taxi_for_you/Features/profile/views/widgets/profile_widget.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/di.dart';
import 'package:taxi_for_you/core/utils/resources/assets_manager.dart';

import '../../../core/utils/resources/color_manager.dart';
import '../../../core/utils/resources/strings_manager.dart';
import '../../common/state_renderer/dialogs.dart';

class ProfileScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AppPreferences appPreferences = instance();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        pageBuilder: PageBuilder(
      scaffoldKey: widget.scaffoldKey,
      allowBackButtonInAppBar: false,
      context: context,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.profile.tr(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: ColorManager.black, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 16),
            CustomProfileWidget(),
            const SizedBox(height: 16),
            MenuWidget(
              menuImage: ImageAssets.logout,
              menuLabel: AppStrings.logout.tr(),
              onPressed: () => ShowDialogHelper.showDialogPopupWithCancel(
                AppStrings.confirmation.tr(),
                AppStrings.logoutConfirmation.tr(),
                context,
                () => Navigator.pop(context),
                () {
                  Navigator.pop(context);
                  appPreferences.logout(context);
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
