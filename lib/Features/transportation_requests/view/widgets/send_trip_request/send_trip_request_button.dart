import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_for_you/Features/transportation_requests/model/transportation_base_model.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/send_trip_request/send_trip_request_viewmodel.dart';
import 'package:taxi_for_you/app/constants.dart';

import '../../../../../core/utils/resources/strings_manager.dart';
import '../../../../common/widgets/custom_text_button.dart';
import '../../../bloc/transportation_bloc.dart';
import '../../../bloc/transportation_event.dart';

class SendTripRequestButton extends StatelessWidget {
  final SendTripRequestViewModel viewModel = SendTripRequestViewModel();
  final TransportationBaseModel transportationBaseModel;
  SendTripRequestButton({
    Key? key,
    required this.transportationBaseModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextButton(
      text: AppStrings.sendRequest.tr(),
      onPressed: () {
        FocusScope.of(context).unfocus();
        inspect(transportationBaseModel);
        viewModel.sendRequest(
            transportationBaseModel, TripStatusConstants.submitted);
        BlocProvider.of<TransportationBloc>(context).add(
          SendTransportationRequest(
            endPoint: viewModel.endPoint,
            transportationBaseModel: transportationBaseModel,
            files: transportationBaseModel.images,
            body: viewModel.jsonBody,
          ),
        );
      },
    );
  }
}
