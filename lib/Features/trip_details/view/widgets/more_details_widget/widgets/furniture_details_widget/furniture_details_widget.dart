import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/furniture/models/furniture_model.dart';
import 'package:taxi_for_you/Features/trip_details/view/widgets/more_details_widget/widgets/furniture_details_widget/widgets/furniture_extra_service.dart';
import 'package:taxi_for_you/Features/trip_details/view/widgets/more_details_widget/widgets/furniture_details_widget/widgets/furniture_transport_items.dart';

import '../../../../../../../core/utils/resources/color_manager.dart';

class FurnitureDetailsWidget extends StatelessWidget {
  final FurnitureModel furnitureModel;
  const FurnitureDetailsWidget({
    Key? key,
    required this.furnitureModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: ColorManager.grey1),
        FurnitureTransportItems(
          furnitureItems: furnitureModel.furnitureItems,
        ),
        const SizedBox(height: 8),
        FurnitureExtraItems(furnitureModel: furnitureModel)
      ],
    );
  }
}
