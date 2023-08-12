import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_for_you/Features/transportation_requests/model/transportation_base_model.dart';
import 'package:taxi_for_you/app/constants.dart';

import '../../../../../core/utils/resources/strings_manager.dart';
import '../../../../common/widgets/custom_text_button.dart';
import '../../../../transportation_requests/bloc/transportation_bloc.dart';
import '../../../../transportation_requests/bloc/transportation_event.dart';
import '../../../../transportation_requests/view/widgets/send_trip_request/send_trip_request_viewmodel.dart';

class SearchCaptainButton extends StatelessWidget {
  final TransportationBaseModel transportationBaseModel;
  final SendTripRequestViewModel sendTripRequestViewModel =
      SendTripRequestViewModel();
  SearchCaptainButton({Key? key, required this.transportationBaseModel})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomTextButton(
      text: AppStrings.searchAnotherCaptain.tr(),
      showIcon: true,
      iconData: Icons.search,
      fontSize: 12,
      showShadow: false,
      onPressed: () {
        // sendTripRequestViewModel.sendRequest(
        //   transportationBaseModel,
        //   TripStatusConstants.submitted,
        // );
        // BlocProvider.of<TransportationBloc>(context).add(
        //   SendTransportationRequest(
        //     endPoint: sendTripRequestViewModel.endPoint,
        //     transportationBaseModel: transportationBaseModel,
        //     files: transportationBaseModel.images,
        //     body: sendTripRequestViewModel.jsonBody,
        //   ),
        // );
      },
    );
  }
}
