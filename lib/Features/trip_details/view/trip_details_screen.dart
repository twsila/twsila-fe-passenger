import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_for_you/Features/common/state_renderer/dialogs.dart';
import 'package:taxi_for_you/Features/common/widgets/custom_reload_widget.dart';
import 'package:taxi_for_you/Features/common/widgets/custom_scaffold.dart';
import 'package:taxi_for_you/Features/common/widgets/page_builder.dart';
import 'package:taxi_for_you/Features/trip_details/bloc/trip_details_bloc.dart';
import 'package:taxi_for_you/Features/trip_details/bloc/trip_details_event.dart';
import 'package:taxi_for_you/Features/trip_details/bloc/trip_details_state.dart';
import 'package:taxi_for_you/Features/trip_details/view/trip_details_viewmodel.dart';
import 'package:taxi_for_you/Features/trip_details/view/widgets/cancel_trip_button.dart';
import 'package:taxi_for_you/Features/trip_details/view/widgets/offers_widget/offers_widget.dart';
import 'package:taxi_for_you/Features/trip_details/view/widgets/trip_details_widget/trip_details_widget.dart';
import 'package:taxi_for_you/core/utils/ext/screen_size_ext.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';

import '../../common/widgets/custom_text_button.dart';

class TripDetailsScreen extends StatefulWidget {
  final int tripId;
  const TripDetailsScreen({
    Key? key,
    required this.tripId,
  }) : super(key: key);

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  final TripDetailsViewModel _viewModel = TripDetailsViewModel();

  @override
  void initState() {
    _viewModel.start();
    BlocProvider.of<TripDetailsBloc>(context)
        .add(GetTripDetailsRequest(tripId: widget.tripId));
    _viewModel.setTimer(
      () => BlocProvider.of<TripDetailsBloc>(context).add(
        GetTripDetailsRequest(tripId: widget.tripId),
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      pageBuilder: PageBuilder(
        scaffoldKey: _viewModel.scaffoldKey,
        context: context,
        displayLoadingIndicator: _viewModel.displayLoadingIndicator,
        appBarTitle: AppStrings.tripDetails.tr(),
        body: Container(
          margin: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: BlocConsumer<TripDetailsBloc, TripDetailsStates>(
              listener: (context, state) {
                if (state is TripDetailsIsLoading) {
                  if (_viewModel.isInit) {
                    _viewModel.isInit = false;
                    setState(() {
                      _viewModel.displayLoadingIndicator = true;
                    });
                  }
                } else {
                  setState(() {
                    _viewModel.displayLoadingIndicator = false;
                  });
                  if (state is TripDetailsSuccessfully) {
                    if (state.tripDetailsModel.tripDetails.acceptedOffer !=
                        null) {
                      _viewModel.cancelTimer();
                    }
                  }
                  if (state is CancelTripSuccessfully) {
                    ShowDialogHelper.showSuccessMessage(
                        AppStrings.cancelTripSuccessfully.tr(), context);
                    Navigator.pop(context);
                  }
                  if (state is TripDetailsFailed) {
                    ShowDialogHelper.showErrorMessage(
                      state.baseResponse.errorMessage ??
                          AppStrings.somethingWentWrong.tr(),
                      context,
                    );
                  }
                  if (state is CancelTripFailed) {
                    ShowDialogHelper.showErrorMessage(
                      state.baseResponse.errorMessage ??
                          AppStrings.somethingWentWrong.tr(),
                      context,
                    );
                  }
                }
              },
              buildWhen: (previous, current) =>
                  current is TripDetailsSuccessfully ||
                  current is TripDetailsFailed,
              builder: (context, state) {
                if (state is TripDetailsSuccessfully) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TripDetailsWidget(
                          trip: state.tripDetailsModel.tripDetails),
                      const SizedBox(height: 16),
                      Divider(color: ColorManager.grey1),
                      OffersWidget(
                        acceptedOffer:
                            state.tripDetailsModel.tripDetails.acceptedOffer,
                        offers: state.tripDetailsModel.tripDetails.offers,
                      ),
                      CancelTripButton(tripId: widget.tripId)
                    ],
                  );
                } else if (state is TripDetailsFailed) {
                  return Padding(
                    padding: EdgeInsets.only(top: context.getHeight() / 3),
                    child: CustomReloadWidget(
                      onPressed: () =>
                          BlocProvider.of<TripDetailsBloc>(context).add(
                        GetTripDetailsRequest(tripId: widget.tripId),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
