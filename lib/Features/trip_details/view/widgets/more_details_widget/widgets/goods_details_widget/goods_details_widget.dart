import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/goods/models/goods_model.dart';
import 'package:taxi_for_you/Features/trip_details/view/widgets/more_details_widget/widgets/goods_details_widget/widgets/goods_extra_services.dart';

import '../../../../../../../core/utils/resources/strings_manager.dart';
import '../../item_widget.dart';

class GoodsDetailsWidget extends StatelessWidget {
  final GoodsModel goodsModel;
  const GoodsDetailsWidget({
    Key? key,
    required this.goodsModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ItemWidget(
                title: AppStrings.materialTypes.tr(),
                text: goodsModel.materialType ?? AppStrings.unknown.tr(),
              ),
            ),
            Expanded(
              child: ItemWidget(
                title: AppStrings.selectPackagingTypes.tr(),
                text: goodsModel.packagingType ?? AppStrings.unknown.tr(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: GoodsExtraServices(goodsModel: goodsModel),
            ),
            Expanded(
              child: ItemWidget(
                title: AppStrings.goodsWeight.tr(),
                text: (goodsModel.payloadWeight ?? AppStrings.unknown.tr())
                    .toString(),
              ),
            )
          ],
        )
      ],
    );
  }
}
