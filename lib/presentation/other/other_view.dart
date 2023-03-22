import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/presentation/common/widgets/custom_back_button.dart';
import 'package:taxi_for_you/presentation/common/widgets/custom_text_outlined_button.dart';
import 'package:taxi_for_you/utils/resources/color_manager.dart';
import 'package:taxi_for_you/utils/resources/routes_manager.dart';
import 'package:taxi_for_you/utils/resources/strings_manager.dart';
import 'package:taxi_for_you/utils/resources/values_manager.dart';

class OtherView extends StatefulWidget {
  const OtherView({Key? key}) : super(key: key);

  @override
  State<OtherView> createState() => _OtherViewState();
}

class _OtherViewState extends State<OtherView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(AppSize.s16),
        padding: const EdgeInsets.only(top: AppSize.s40),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: CustomBackButton(
                onPressed: () => Navigator.pop(context),
              ),
            ),
            const SizedBox(height: AppSize.s40),
            Text(
              AppStrings.whichGoods.tr(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: ColorManager.black, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: AppSize.s40),
            //Furniture View
            CustomTextOutlinedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, Routes.furnitureRoute),
              text: AppStrings.furniture.tr(),
            ),
            //Goods View
            CustomTextOutlinedButton(
              onPressed: () => Navigator.pushNamed(context, Routes.goodsRoute),
              text: AppStrings.goods.tr(),
            ),
            //Freezers View
            CustomTextOutlinedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, Routes.freezerRoute),
              text: AppStrings.freezers.tr(),
            ),
            //Surfaces View
            CustomTextOutlinedButton(
              onPressed: () => Navigator.pushNamed(context, Routes.carAidRoute),
              text: AppStrings.carAid.tr(),
            ),
            //Water Tank View
            CustomTextOutlinedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, Routes.waterTankRoute),
              text: AppStrings.waterTank.tr(),
            ),
            //Cisterns View
            CustomTextOutlinedButton(
              onPressed: () {},
              text: AppStrings.cisterns.tr(),
            ),
          ],
        ),
      ),
    );
  }
}
