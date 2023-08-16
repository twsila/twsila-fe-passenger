import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_for_you/Features/common/state_renderer/dialogs.dart';
import 'package:taxi_for_you/Features/transportation_requests/bloc/transportation_bloc.dart';
import 'package:taxi_for_you/Features/transportation_requests/bloc/transportation_state.dart';
import 'package:taxi_for_you/Features/trip_details/view/widgets/offers_buttons/need_help_button.dart';
import 'package:taxi_for_you/Features/trip_details/view/widgets/offers_buttons/refund_button.dart';
import 'package:taxi_for_you/Features/trip_details/view/widgets/offers_buttons/search_captain_button.dart';
import 'package:taxi_for_you/app/constants.dart';
import 'package:taxi_for_you/core/utils/helpers/trip_helper.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';
import '../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../core/utils/resources/styles_manager.dart';
import '../../../../../my_trips/bloc/my_trips_bloc.dart';
import '../../../../../my_trips/bloc/my_trips_event.dart';
import '../../../../../transportation_requests/model/transportation_base_model.dart';
import '../../../../bloc/trip_details_bloc.dart';
import '../../../../bloc/trip_details_event.dart';
import '../../trip_details_widget/trip_details_widget.dart';

class TripCancelled extends StatefulWidget {
  final TransportationBaseModel transportationBaseModel;
  TripCancelled({Key? key, required this.transportationBaseModel})
      : super(key: key);

  @override
  State<TripCancelled> createState() => _TripCancelledState();
}

class _TripCancelledState extends State<TripCancelled> {
  bool isNewCaptainLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TransportationBloc, TransportationRequestStates>(
        listener: (context, state) {
      isNewCaptainLoading = state is TransportationRequestIsLoading;
      if (state is TransportationRequestSuccessfully) {
        BlocProvider.of<TripDetailsBloc>(context).add(GetTripDetailsRequest(
            tripId: widget.transportationBaseModel.tripId!));
        BlocProvider.of<MyTripsBloc>(context).add(
          GetUserTrips(tripModelType: 4),
        );
      } else if (state is TransportationRequestFailed) {
        ShowDialogHelper.showErrorMessage(
          state.baseResponse.errorMessage ?? AppStrings.somethingWentWrong.tr(),
          context,
        );
      }
    }, builder: (context, state) {
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.red,
            child: Row(
              children: [
                const Icon(
                  Icons.cancel,
                  color: Colors.white,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    TripHelper.getTripText(widget.transportationBaseModel),
                    style: getMediumStyle(color: Colors.white, fontSize: 16),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(16),
            child: Column(
              children: [
                TripDetailsWidget(trip: widget.transportationBaseModel),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: isNewCaptainLoading
                          ? Center(
                              child: SizedBox(
                                height: 32,
                                width: 32,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  backgroundColor: ColorManager.primary,
                                ),
                              ),
                            )
                          : SearchCaptainButton(
                              transportationBaseModel:
                                  widget.transportationBaseModel,
                            ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: widget.transportationBaseModel.cancelledBy ==
                              TripStatusConstants.cancelledByDriver
                          ? RefundButton(
                              tripId: widget.transportationBaseModel.tripId!)
                          : const SizedBox(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(color: Colors.grey),
                NeedHelpButton(tripId: widget.transportationBaseModel.tripId!),
              ],
            ),
          ),
        ],
      );
    });
  }
}
