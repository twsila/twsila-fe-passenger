import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_for_you/Features/my_trips/bloc/my_trips_bloc.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/transport_request_viewmodel.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/custom_widgets/transportation_top_widget.dart';
import 'package:taxi_for_you/Features/trip_details/view/trip_details_screen.dart';

import '../../../../core/utils/resources/routes_manager.dart';
import '../../../../core/utils/resources/strings_manager.dart';
import '../../common/state_renderer/dialogs.dart';
import '../../common/widgets/custom_scaffold.dart';
import '../../common/widgets/page_builder.dart';
import '../../my_trips/bloc/my_trips_event.dart';
import '../../request_service/bloc/draft_trip_bloc.dart';
import '../../request_service/bloc/draft_trip_event.dart';
import '../bloc/transportation_bloc.dart';
import '../bloc/transportation_state.dart';
import '../model/transportation_base_model.dart';

class TransportRequestScreen extends StatefulWidget {
  final TransportationBaseModel transportationBaseModel;
  final bool hasImages;

  const TransportRequestScreen({
    Key? key,
    required this.transportationBaseModel,
    this.hasImages = true,
  }) : super(key: key);

  @override
  State<TransportRequestScreen> createState() => _TransportRequestScreenState();
}

class _TransportRequestScreenState extends State<TransportRequestScreen> {
  final TransportRequestViewModel _viewModel = TransportRequestViewModel();

  @override
  void initState() {
    _viewModel.context = context;
    _viewModel.start(widget.transportationBaseModel, widget.hasImages);
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await _viewModel.cacheOnBack();
        return true;
      },
      child: BlocListener<TransportationBloc, TransportationRequestStates>(
          listener: (context, state) {
            if (state is TransportationRequestIsLoading) {
              setState(() {
                _viewModel.displayLoadingIndicator = true;
              });
            } else {
              setState(() {
                _viewModel.displayLoadingIndicator = false;
              });
            }
            if (state is TransportationRequestSuccessfully) {
              BlocProvider.of<DraftTripBloc>(context).add(GetDraftTrip());
              if (state.transportationBaseModel.tripStatus == 'DRAFT') {
                Navigator.pop(context);
                return;
              }
              ShowDialogHelper.showSuccessMessage(
                AppStrings.tripConfirmationSucceeded.tr(),
                context,
              );
              BlocProvider.of<MyTripsBloc>(context).add(
                GetUserTrips(tripModelType: 5),
              );
              Future.delayed(
                const Duration(seconds: 1),
                () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TripDetailsScreen(tripId: state.tripId),
                  ),
                ),
              );
            }
            if (state is TransportationRequestFailed) {
              ShowDialogHelper.showErrorMessage(
                state.baseResponse.errorMessage ?? 'Something went wrong',
                context,
              );
            }
          },
          child: CustomScaffold(
            pageBuilder: PageBuilder(
              scaffoldKey: _viewModel.scaffoldKey,
              displayLoadingIndicator: _viewModel.displayLoadingIndicator,
              allowBackButtonInAppBar: false,
              context: context,
              body: ValueListenableBuilder<int>(
                  valueListenable: _viewModel.selectedIndex,
                  builder: (BuildContext context, int selectedIndex, _) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TransportationTopWidget(
                          transportViewModel: _viewModel,
                        ),
                        Expanded(
                          child: PageView(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: _viewModel.controller,
                            children: _viewModel.screens,
                            onPageChanged: (value) =>
                                _viewModel.selectedIndex.value = value,
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          )),
    );
  }
}
