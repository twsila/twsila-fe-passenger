import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/categories/categories_viewmodel.dart';
import 'package:taxi_for_you/Features/common/state_renderer/dialogs.dart';
import 'package:taxi_for_you/Features/common/widgets/custom_square_button.dart';
import 'package:taxi_for_you/core/utils/ext/screen_size_ext.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';
import 'package:taxi_for_you/core/utils/resources/routes_manager.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';

import '../../core/utils/resources/assets_manager.dart';
import '../common/widgets/custom_language_widget.dart';

class CategoriesView extends StatelessWidget {
  final CategoriesViewModel categoriesViewModel = CategoriesViewModel();
  CategoriesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ShowDialogHelper.showDialogPopupWithCancel(
          AppStrings.confirmation.tr(),
          AppStrings.logoutConfirmation.tr(),
          context,
          () => Navigator.pop(context),
          () async {
            Navigator.pop(context);
            categoriesViewModel.logout(context);
            Navigator.pop(context);
          },
        );

        return false;
      },
      child: Container(
        color: ColorManager.white,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: SizedBox(
                height: context.getHeight() / 3,
                child: Image.asset(ImageAssets.car),
              ),
            ),
            Positioned(
              top: context.getHeight() / 16,
              right: 32,
              child: const LanguageWidget(),
            ),
            Positioned(
              bottom: 16,
              right: 32,
              child: SizedBox(
                width: 120,
                child: Image.asset(ImageAssets.logoImg),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                      child: Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.goodAfternoon.tr(),
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        Text(
                          AppStrings.thinkingOfTravel.tr(),
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ],
                    ),
                  )),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          child: CustomSquareButton(
                              onPressed: () {},
                              text: AppStrings.people.tr(),
                              iconData: Icons.people),
                        ),
                        Flexible(
                          child: CustomSquareButton(
                              onPressed: () {
                                Navigator.pushNamed(context, Routes.otherRoute);
                              },
                              text: AppStrings.other.tr(),
                              iconData: Icons.chair),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
