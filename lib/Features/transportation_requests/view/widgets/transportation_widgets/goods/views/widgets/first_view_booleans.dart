import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/goods/models/goods_model.dart';

import '../../../../../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../../../../../../core/utils/resources/styles_manager.dart';
import '../../../../../../../common/widgets/custom_checkbox.dart';

class GoodsFirstViewBooleans extends StatefulWidget {
  final GoodsModel goodsModel;

  const GoodsFirstViewBooleans({Key? key, required this.goodsModel})
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
            checked: widget.goodsModel.containsLift,
            fieldName: AppStrings.crane.tr(),
            onChange: (checked) {
              widget.goodsModel.containsLift = checked;
            }),
        CustomCheckBox(
            checked: widget.goodsModel.containsLoading,
            fieldName: AppStrings.unloadAndLoad.tr(),
            onChange: (checked) {
              widget.goodsModel.containsLoading = checked;
            }),
        CustomCheckBox(
            checked: widget.goodsModel.containsPacking,
            fieldName: AppStrings.wrapping.tr(),
            onChange: (checked) {
              widget.goodsModel.containsPacking = checked;
            }),
      ],
    );
  }
}
