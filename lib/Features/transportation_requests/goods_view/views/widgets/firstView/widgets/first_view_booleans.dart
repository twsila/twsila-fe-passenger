import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../../../core/utils/resources/styles_manager.dart';
import '../../../../../../common/widgets/custom_checkbox.dart';
import '../../../goods_viewmodel.dart';

class GoodsFirstViewBooleans extends StatefulWidget {
  final GoodsViewModel viewModel;

  const GoodsFirstViewBooleans({Key? key, required this.viewModel})
      : super(key: key);
  @override
  _GoodsFirstViewBooleansState createState() => _GoodsFirstViewBooleansState();
}

class _GoodsFirstViewBooleansState extends State<GoodsFirstViewBooleans> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.extraServices.tr(),
          textAlign: TextAlign.start,
          style: getMediumStyle(
            color: ColorManager.titlesTextColor,
            fontSize: 16,
          ),
        ),
        CustomCheckBox(
            checked: widget.viewModel.goodsModel.containsLift,
            fieldName: AppStrings.crane.tr(),
            onChange: (checked) {
              widget.viewModel.goodsModel.containsLift = checked;
            }),
        CustomCheckBox(
            checked: widget.viewModel.goodsModel.containsLoading,
            fieldName: AppStrings.unloadAndLoad.tr(),
            onChange: (checked) {
              widget.viewModel.goodsModel.containsLoading = checked;
            }),
        CustomCheckBox(
            checked: widget.viewModel.goodsModel.containsPacking,
            fieldName: AppStrings.wrapping.tr(),
            onChange: (checked) {
              widget.viewModel.goodsModel.containsPacking = checked;
            }),
      ],
    );
  }
}
