import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_for_you/Features/common/state_renderer/dialogs.dart';
import 'package:taxi_for_you/Features/common/widgets/custom_circular_indicator.dart';
import 'package:taxi_for_you/Features/common/widgets/custom_close_button.dart';
import 'package:taxi_for_you/Features/common/widgets/custom_text_button.dart';
import 'package:taxi_for_you/Features/common/widgets/custom_text_input_field.dart';
import 'package:taxi_for_you/Features/home_features/my_trips/bloc/my_trips_bloc.dart';
import 'package:taxi_for_you/Features/home_features/my_trips/bloc/my_trips_event.dart';
import 'package:taxi_for_you/Features/payment/bloc/payment_bloc.dart';
import 'package:taxi_for_you/Features/payment/bloc/payment_event.dart';
import 'package:taxi_for_you/Features/payment/bloc/payment_state.dart';
import 'package:taxi_for_you/Features/payment/views/payment_screen/payment_viewmodel.dart';
import 'package:taxi_for_you/Features/transportation_requests/model/transportation_base_model.dart';
import 'package:taxi_for_you/Features/trip_details/bloc/trip_details_bloc.dart';
import 'package:taxi_for_you/Features/trip_details/bloc/trip_details_event.dart';
import 'package:taxi_for_you/Features/trip_details/model/offer_model.dart';
import 'package:taxi_for_you/core/utils/resources/assets_manager.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';

class PaymentScreen extends StatefulWidget {
  final TransportationBaseModel tripDetails;
  final OfferModel offer;
  const PaymentScreen(
      {Key? key, required this.offer, required this.tripDetails})
      : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final PaymentViewModel paymentViewModel = PaymentViewModel();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppStrings.enterCardDetails.tr()),
                  const CustomCloseButton(),
                ],
              ),
              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 24),
              Row(
                children: [
                  Image.asset(ImageAssets.visa),
                  const SizedBox(width: 16),
                  Image.asset(ImageAssets.masterCard),
                ],
              ),
              const SizedBox(height: 16),
              CustomTextInputField(
                controller: paymentViewModel.cardNumberController,
                showLabelText: true,
                labelText: AppStrings.cardNumber.tr(),
                hintText: AppStrings.cardNumber.tr(),
              ),
              const SizedBox(height: 16),
              CustomTextInputField(
                controller: paymentViewModel.cardHolderController,
                showLabelText: true,
                labelText: AppStrings.cardHolderName.tr(),
                hintText: AppStrings.cardHolderName.tr(),
              ),
              const SizedBox(height: 16),
              CustomTextInputField(
                controller: paymentViewModel.cardExpiryDateController,
                showLabelText: true,
                labelText: AppStrings.cardExpiryDate.tr(),
                hintText: '__/__',
                onChanged: (value) {
                  if (value.length == 2) {
                    paymentViewModel.cardExpiryDateController.text += '/';
                  }
                },
                suffixIcon: Image.asset(ImageAssets.calendar),
              ),
              const SizedBox(height: 16),
              CustomTextInputField(
                controller: paymentViewModel.cardCVVController,
                showLabelText: true,
                labelText: AppStrings.cvv.tr(),
                hintText: AppStrings.cvv.tr(),
                suffixIcon: Image.asset(ImageAssets.info),
              ),
              const SizedBox(height: 32),
              BlocConsumer<PaymentBloc, PaymentStates>(
                  listener: ((context, state) {
                if (state is PaymentSuccessfully) {
                  BlocProvider.of<TripDetailsBloc>(context).add(
                    GetTripDetailsRequest(tripId: widget.tripDetails.tripId!),
                  );
                  Navigator.pop(context);
                  BlocProvider.of<MyTripsBloc>(context).add(
                    GetUserTrips(tripModelType: 5),
                  );
                } else if (state is PaymentFailed) {
                  ShowDialogHelper.showErrorMessage(
                    state.baseResponse.errorMessage ??
                        AppStrings.somethingWentWrong.tr(),
                    context,
                  );
                }
              }), builder: (context, state) {
                if (state is PaymentIsLoading) {
                  return const Center(child: CustomCircularProgressIndicator());
                }
                return CustomTextButton(
                  text: AppStrings.pay.tr() +
                      ' ${(widget.offer.driverOffer)} ' +
                      paymentViewModel.appPreferences.getCurrentCurrnecy(),
                  onPressed: () {
                    BlocProvider.of<PaymentBloc>(context).add(
                        SendPaymentRequest(
                            tripId: widget.tripDetails.tripId.toString()));
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
