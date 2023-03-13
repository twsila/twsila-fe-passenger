import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/presentation/categories/categories_viewmodel.dart';
import 'package:taxi_for_you/presentation/common/state_renderer/dialogs.dart';
import 'package:taxi_for_you/presentation/common/widgets/custom_square_button.dart';
import 'package:taxi_for_you/utils/ext/screen_size_ext.dart';
import 'package:taxi_for_you/utils/resources/color_manager.dart';
import 'package:taxi_for_you/utils/resources/routes_manager.dart';
import 'package:taxi_for_you/utils/resources/strings_manager.dart';
import 'package:taxi_for_you/utils/resources/values_manager.dart';

import '../../utils/resources/assets_manager.dart';

class CategoriesView extends StatelessWidget {
  CategoriesViewModel categoriesViewModel = CategoriesViewModel();
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
          () {
            Navigator.pop(context);
            categoriesViewModel.logout(context);
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
              bottom: 16,
              right: 32,
              child: SizedBox(
                width: 120,
                child: Image.asset(ImageAssets.logoImg),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: AppSize.s32),
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
