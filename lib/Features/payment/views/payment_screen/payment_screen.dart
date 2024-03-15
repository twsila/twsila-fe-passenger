import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moyasar/moyasar.dart';
import 'package:taxi_for_you/Features/common/state_renderer/dialogs.dart';
import 'package:taxi_for_you/Features/payment/bloc/payment_bloc.dart';
import 'package:taxi_for_you/Features/payment/bloc/payment_event.dart';
import 'package:taxi_for_you/Features/transportation_requests/model/transportation_base_model.dart';
import 'package:taxi_for_you/Features/trip_details/model/offer_model.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/constants.dart';
import 'package:taxi_for_you/app/di.dart';
import 'package:taxi_for_you/core/utils/resources/langauge_manager.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';

class PaymentScreen extends StatefulWidget {
  final TransportationBaseModel tripDetails;
  final OfferModel offer;

  const PaymentScreen({
    super.key,
    required this.tripDetails,
    required this.offer,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final AppPreferences appPreferences = instance();
  PaymentConfig paymentConfig = PaymentConfig(
    publishableApiKey: PaymentConstants.primaryKey,
    amount: 1,
    description: 'order #1324',
    metadata: {'size': '250g'},
  );

  @override
  void initState() {
    paymentConfig.amount = widget.offer.driverOffer.toInt() * 100;
    super.initState();
  }

  void onPaymentResult(result) {
    if (result is PaymentResponse) {
      switch (result.status) {
        case PaymentStatus.paid:
          ShowDialogHelper.showSuccessMessage(
            AppStrings.paymentSuccess.tr(),
            context,
          );
          BlocProvider.of<PaymentBloc>(context).add(
            SendPaymentRequest(
              tripId: widget.tripDetails.tripId.toString(),
            ),
          );
          Navigator.pop(context);
          break;
        case PaymentStatus.failed:
          ShowDialogHelper.showErrorMessage(
            AppStrings.paymentFailed.tr(),
            context,
          );
          break;
        default:
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: CreditCard(
        config: paymentConfig,
        onPaymentResult: onPaymentResult,
        locale:
            appPreferences.getAppLanguage() == LanguageType.ENGLISH.getValue()
                ? const Localization.en()
                : const Localization.ar(),
      ),
    );
  }
}
