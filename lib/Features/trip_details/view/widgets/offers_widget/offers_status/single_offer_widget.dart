import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_for_you/Features/common/widgets/custom_bottom_sheet.dart';
import 'package:taxi_for_you/Features/common/widgets/custom_circular_indicator.dart';
import 'package:taxi_for_you/Features/common/widgets/custom_text_outlined_button.dart';
import 'package:taxi_for_you/Features/payment/views/payment_screen/payment_screen.dart';
import 'package:taxi_for_you/Features/transportation_requests/model/transportation_base_model.dart';
import 'package:taxi_for_you/Features/trip_details/bloc/trip_details_bloc.dart';
import 'package:taxi_for_you/Features/trip_details/bloc/trip_details_event.dart';
import 'package:taxi_for_you/Features/trip_details/bloc/trip_details_state.dart';
import 'package:taxi_for_you/Features/trip_details/model/offer_model.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/constants.dart';
import 'package:taxi_for_you/app/di.dart';
import 'package:taxi_for_you/core/utils/resources/assets_manager.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';
import 'package:taxi_for_you/core/utils/resources/styles_manager.dart';

import '../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../common/widgets/custom_text_button.dart';

class SingleOfferWidget extends StatefulWidget {
  final TransportationBaseModel tripDetails;
  final OfferModel offer;
  const SingleOfferWidget({
    Key? key,
    required this.tripDetails,
    required this.offer,
  }) : super(key: key);

  @override
  State<SingleOfferWidget> createState() => _SingleOfferWidgetState();
}

class _SingleOfferWidgetState extends State<SingleOfferWidget> {
  final AppPreferences _appPrefs = instance();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Flexible(
                flex: 1,
                child: Container(
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
                  child: ClipRRect(
                    child: widget.offer.driverModel.image != null &&
                            widget.offer.driverModel.image!.imageURL != null
                        ? Image.network(
                            widget.offer.driverModel.image!.imageURL!)
                        : Image.asset(ImageAssets.logoImg),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Flexible(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.offer.driverModel.carModel.carManufacturerId
                          .carManufacturer,
                      style: getBoldStyle(
                          color: ColorManager.primaryTextColor, fontSize: 18),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          widget.offer.driverModel.firstName +
                              ' ' +
                              widget.offer.driverModel.lastName,
                          style: getBoldStyle(
                              color: ColorManager.primaryTextColor,
                              fontSize: 16),
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
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          widget.offer.driverOffer.toString(),
                          style: getBoldStyle(
                            color: ColorManager.primaryTextColor,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _appPrefs.getCurrentCurrnecy(),
                          style: getMediumStyle(
                            color: ColorManager.primaryTextColor,
                            fontSize: 16,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          widget.tripDetails.acceptedOffer != null &&
                  (widget.tripDetails.acceptedOffer!.offer.offerId ==
                      widget.offer.offerId) &&
                  widget.tripDetails.tripStatus == TripStatusConstants.payment
              ? Container(
                  margin: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: CustomTextOutlinedButton(
                          text: AppStrings.cancel.tr(),
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 16),
                      Flexible(
                        flex: 2,
                        child: CustomTextButton(
                          text: AppStrings.goPay.tr(),
                          imageData: ImageAssets.payment,
                          onPressed: () {
                            CustomBottomSheet.displayModalBottomSheetList(
                              context: context,
                              showCloseButton: false,
                              initialChildSize: 0.9,
                              customWidget: PaymentScreen(
                                tripDetails: widget.tripDetails,
                                offer: widget.offer,
                              ),
                            );
                          },
                          showIcon: false,
                        ),
                      ),
                    ],
                  ),
                )
              : BlocBuilder<TripDetailsBloc, TripDetailsStates>(
                  builder: (context, state) {
                  if (state is AcceptOfferIsLoading) {
                    return const CustomCircularProgressIndicator();
                  }
                  return Container(
                    margin: const EdgeInsets.all(8),
                    child: CustomTextButton(
                      text: AppStrings.chooseOffer.tr(),
                      imageData: ImageAssets.payment,
                      onPressed: () {
                        BlocProvider.of<TripDetailsBloc>(context).add(
                            AcceptOfferRequest(offerId: widget.offer.offerId));
                      },
                      showIcon: false,
                    ),
                  );
                }),
        ],
      ),
    );
  }
}
