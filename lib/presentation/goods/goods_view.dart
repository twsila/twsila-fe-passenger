import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/presentation/common/widgets/custom_back_button.dart';
import 'package:taxi_for_you/presentation/common/widgets/custom_text_outlined_button.dart';
import 'package:taxi_for_you/utils/resources/color_manager.dart';
import 'package:taxi_for_you/utils/resources/routes_manager.dart';
import 'package:taxi_for_you/utils/resources/strings_manager.dart';
import 'package:taxi_for_you/utils/resources/values_manager.dart';

class GoodsView extends StatefulWidget {
  const GoodsView({Key? key}) : super(key: key);

  @override
  State<GoodsView> createState() => _GoodsViewState();
}

class _GoodsViewState extends State<GoodsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(AppSize.s16),
        padding: const EdgeInsets.only(top: AppSize.s40),
        child: Column(
          children: [
            Row(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomBackButton(
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  AppStrings.goods.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(fontSize: 24, color: ColorManager.black),
                )
              ],
            ),
            const SizedBox(height: AppSize.s40),
            Text(
              AppStrings.whichGoods.tr(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: ColorManager.black, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: AppSize.s40),
            CustomTextOutlinedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, Routes.furnitureRoute),
                text: AppStrings.furniture.tr()),
            CustomTextOutlinedButton(
                onPressed: () {}, text: AppStrings.goods.tr()),
            CustomTextOutlinedButton(
                onPressed: () {}, text: AppStrings.freezers.tr()),
            CustomTextOutlinedButton(
                onPressed: () {}, text: AppStrings.surfaces.tr()),
            CustomTextOutlinedButton(
                onPressed: () {}, text: AppStrings.cisterns.tr()),
          ],
        ),
      ),
    );
  }
}
