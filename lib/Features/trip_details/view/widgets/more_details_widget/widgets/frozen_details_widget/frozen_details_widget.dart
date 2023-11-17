import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/freezers/models/freezers-model.dart';
import 'package:taxi_for_you/Features/trip_details/view/widgets/more_details_widget/widgets/frozen_details_widget/widgets/frozen_extra_services.dart';

import '../../../../../../../core/utils/resources/strings_manager.dart';
import '../../item_widget.dart';

class FrozenDetailsWidget extends StatelessWidget {
  final FreezersModel freezersModel;
  const FrozenDetailsWidget({
    Key? key,
    required this.freezersModel,
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
                title: AppStrings.shippedTypes.tr(),
                text: freezersModel.shippedType != null
                    ? freezersModel.shippedType!.value
                    : AppStrings.unknown.tr(),
              ),
            ),
            Expanded(
              child: ItemWidget(
                title: AppStrings.materialsTobeShipped.tr(),
                text: freezersModel.frozenMaterial != null
                    ? freezersModel.frozenMaterial!.value
                    : AppStrings.unknown.tr(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        FrozenExtraServices(freezersModel: freezersModel),
      ],
    );
  }
}
