import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/common/widgets/custom_scaffold.dart';
import 'package:taxi_for_you/Features/common/widgets/page_builder.dart';
import 'package:taxi_for_you/Features/menu/views/menu_viewmodel.dart';
import 'package:taxi_for_you/Features/menu/views/widgets/menu_widget.dart';
import 'package:taxi_for_you/Features/menu/views/widgets/profile_widget.dart';
import 'package:taxi_for_you/core/utils/resources/assets_manager.dart';

import '../../../core/utils/resources/color_manager.dart';
import '../../../core/utils/resources/strings_manager.dart';
import '../../common/state_renderer/dialogs.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final MenuViewModel _viewModel = MenuViewModel();

  @override
  void initState() {
    _viewModel.context = context;
    _viewModel.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      pageBuilder: PageBuilder(
        scaffoldKey: _viewModel.scaffoldKey,
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
              CustomProfileWidget(userModel: _viewModel.userModel),
              const SizedBox(height: 32),
              MenuWidget(
                menuImage: ImageAssets.payment,
                menuLabel: AppStrings.walletAndPayments.tr(),
                onPressed: () {},
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                child: const Divider(),
              ),
              MenuWidget(
                menuImage: ImageAssets.gift,
                menuLabel: AppStrings.inviteAndWin.tr(),
                onPressed: () {},
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                child: const Divider(),
              ),
              MenuWidget(
                menuImage: ImageAssets.getHelp,
                menuLabel: AppStrings.getHelp.tr(),
                onPressed: () {},
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                child: const Divider(),
              ),
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
                    _viewModel.appPreferences.logout(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
