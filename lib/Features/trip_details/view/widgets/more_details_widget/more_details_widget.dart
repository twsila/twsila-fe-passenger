import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/cisterns/models/cisterns_model.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/freezers/models/freezers-model.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/furniture/models/furniture_model.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/goods/models/goods_model.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/water_tank/models/water_model.dart';
import 'package:taxi_for_you/Features/trip_details/view/widgets/more_details_widget/widgets/cisterns_details_widget.dart';
import 'package:taxi_for_you/Features/trip_details/view/widgets/more_details_widget/widgets/frozen_details_widget/frozen_details_widget.dart';
import 'package:taxi_for_you/Features/trip_details/view/widgets/more_details_widget/widgets/furniture_details_widget/furniture_details_widget.dart';
import 'package:taxi_for_you/Features/trip_details/view/widgets/more_details_widget/widgets/goods_details_widget/goods_details_widget.dart';
import 'package:taxi_for_you/Features/trip_details/view/widgets/more_details_widget/widgets/water_details_widget.dart';

import '../../../../../core/utils/resources/color_manager.dart';
import '../../../../transportation_requests/model/transportation_base_model.dart';

class MoreDetailsWidget extends StatefulWidget {
  final TransportationBaseModel transportationBaseModel;
  const MoreDetailsWidget({
    Key? key,
    required this.transportationBaseModel,
  }) : super(key: key);

  @override
  State<MoreDetailsWidget> createState() => _MoreDetailsWidgetState();
}

class _MoreDetailsWidgetState extends State<MoreDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.transportationBaseModel is FurnitureModel)
          FurnitureDetailsWidget(
            furnitureModel: widget.transportationBaseModel as FurnitureModel,
          ),
        if (widget.transportationBaseModel is GoodsModel)
          GoodsDetailsWidget(
            goodsModel: widget.transportationBaseModel as GoodsModel,
          ),
        if (widget.transportationBaseModel is FreezersModel)
          FrozenDetailsWidget(
            freezersModel: widget.transportationBaseModel as FreezersModel,
          ),
        if (widget.transportationBaseModel is WaterModel)
          WaterDetailsWidget(
            waterModel: widget.transportationBaseModel as WaterModel,
          ),
        if (widget.transportationBaseModel is CisternsModel)
          CisternsDetailsWidget(
            cisternsModel: widget.transportationBaseModel as CisternsModel,
          ),
        Divider(color: ColorManager.grey1),
      ],
    );
  }
}
