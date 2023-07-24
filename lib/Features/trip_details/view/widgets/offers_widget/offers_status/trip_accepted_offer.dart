import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/trip_details/view/widgets/offers_widget/offers_status/single_offer_widget.dart';
import 'package:taxi_for_you/core/utils/ext/screen_size_ext.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../core/utils/resources/assets_manager.dart';
import '../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../../core/utils/resources/styles_manager.dart';
import '../../../../../common/widgets/custom_text_button.dart';
import '../../../../model/offer_model.dart';

class TripAccepterdOffer extends StatefulWidget {
  final OfferModel offer;
  const TripAccepterdOffer({
    Key? key,
    required this.offer,
  }) : super(key: key);

  @override
  State<TripAccepterdOffer> createState() => _TripAccepterdOfferState();
}

class _TripAccepterdOfferState extends State<TripAccepterdOffer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.driverDetails.tr(),
          style: getMediumStyle(
            color: ColorManager.primaryTextColor,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                  color: ColorManager.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                )
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text(
                    widget.offer.driverModel.firstName +
                        ' ' +
                        widget.offer.driverModel.lastName,
                    style: getBoldStyle(
                        color: ColorManager.primaryTextColor, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Image.asset(ImageAssets.star),
                  const SizedBox(height: 4),
                  Text(
                    widget.offer.driverModel.rating.toString(),
                    style: getBoldStyle(
                      color: ColorManager.primaryTextColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.offer.driverModel.carModel.carManufacturerId
                              .carManufacturer,
                          style: getBoldStyle(
                              color: ColorManager.primaryTextColor,
                              fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          margin: const EdgeInsets.all(0),
                          child: CustomTextButton(
                            fontSize: 12,
                            text: AppStrings.driverCall.tr(),
                            onPressed: () {
                              final Uri launchUri = Uri(
                                scheme: 'tel',
                                path: widget.offer.driverModel.mobile,
                              );
                              launchUrl(launchUri);
                            },
                            iconData: Icons.call_outlined,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      height: 58,
                      width: 58,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          boxShadow: [
                            BoxShadow(
                              color: ColorManager.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            )
                          ]),
                      child: ClipRRect(
                        child: widget.offer.driverModel.image != null &&
                                widget.offer.driverModel.image!.imageURL != null
                            ? Image.network(
                                widget.offer.driverModel.image!.imageURL!)
                            : Image.asset(ImageAssets.logoImg),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
