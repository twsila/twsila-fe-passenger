import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/goods/views/goods_viewmodel.dart';

import '../../../../../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../../../common/widgets/custom_dropdown.dart';

class GoodsDropdownsView extends StatefulWidget {
  final GoodsViewModel goodsViewModel;
  const GoodsDropdownsView({
    Key? key,
    required this.goodsViewModel,
  }) : super(key: key);

  @override
  State<GoodsDropdownsView> createState() => _GoodsDropdownsViewState();
}

class _GoodsDropdownsViewState extends State<GoodsDropdownsView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomDropDown(
          stringsArr: widget.goodsViewModel.materialTypes,
          intialValue: widget.goodsViewModel.goodsModel.materialType,
          title: AppStrings.materialTypes.tr(),
          errorMessage: AppStrings.dropdownError.tr(),
          onChanged: (value) {
            setState(() {
              widget.goodsViewModel.goodsModel.materialType = value;
              widget.goodsViewModel.validateFirstScreen();
            });
          },
        ),
        const SizedBox(height: 16),
        CustomDropDown(
          stringsArr: widget.goodsViewModel.packagingTypes,
          intialValue: widget.goodsViewModel.goodsModel.packagingType,
          title: AppStrings.packagingTypes.tr(),
          errorMessage: AppStrings.dropdownError.tr(),
          onChanged: (value) {
            setState(() {
              widget.goodsViewModel.goodsModel.packagingType = value;
              widget.goodsViewModel.validateFirstScreen();
            });
          },
        ),
      ],
    );
  }
}
