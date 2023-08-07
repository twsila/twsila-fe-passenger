import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/transportation_requests/model/transportation_base_model.dart';
import 'package:taxi_for_you/Features/trip_details/view/widgets/offers_widget/offers_status/single_offer_widget.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';

import '../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../core/utils/resources/styles_manager.dart';

class TripAllOffer extends StatefulWidget {
  final TransportationBaseModel transportationBaseModel;
  const TripAllOffer({
    Key? key,
    required this.transportationBaseModel,
  }) : super(key: key);

  @override
  State<TripAllOffer> createState() => _TripAllOfferState();
}

class _TripAllOfferState extends State<TripAllOffer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.offers.tr(),
          style: getMediumStyle(
            color: ColorManager.primaryTextColor,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.transportationBaseModel.offers!.length,
          itemBuilder: (context, index) {
            return SingleOfferWidget(
                offer: widget.transportationBaseModel.offers![index]);
          },
        )
      ],
    );
  }
}
