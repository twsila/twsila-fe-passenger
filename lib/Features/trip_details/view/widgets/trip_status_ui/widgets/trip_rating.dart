import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_for_you/Features/common/state_renderer/dialogs.dart';
import 'package:taxi_for_you/Features/common/widgets/custom_circular_indicator.dart';
import 'package:taxi_for_you/Features/common/widgets/custom_rating_widget.dart';
import 'package:taxi_for_you/Features/common/widgets/custom_text_button.dart';
import 'package:taxi_for_you/Features/transportation_requests/model/transportation_base_model.dart';
import 'package:taxi_for_you/Features/trip_details/bloc/trip_details_bloc.dart';
import 'package:taxi_for_you/Features/trip_details/bloc/trip_details_event.dart';
import 'package:taxi_for_you/Features/trip_details/bloc/trip_details_state.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';
import 'package:taxi_for_you/core/utils/resources/strings_manager.dart';
import 'package:taxi_for_you/core/utils/resources/styles_manager.dart';

class TripRating extends StatefulWidget {
  final TransportationBaseModel tripDetails;

  const TripRating({
    Key? key,
    required this.tripDetails,
  }) : super(key: key);

  @override
  State<TripRating> createState() => _TripRatingState();
}

class _TripRatingState extends State<TripRating> {
  int tripRating = 0;

  int driverRating = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TripDetailsBloc, TripDetailsStates>(
      listener: ((context, state) {
        if (state is RatingTripSuccessfully) {
          BlocProvider.of<TripDetailsBloc>(context)
              .add(GetTripDetailsRequest(tripId: widget.tripDetails.tripId!));
        } else if (state is RatingTripFailed) {
          ShowDialogHelper.showErrorMessage(
            state.baseResponse.errorMessage ??
                AppStrings.somethingWentWrong.tr(),
            context,
          );
        }
      }),
      builder: (context, state) {
        return Column(
          children: [
            Text(
              AppStrings.tripRate.tr(),
              style: getMediumStyle(
                  color: ColorManager.primaryTextColor, fontSize: 16),
            ),
            CustomRatingWidget(
              intialRating: tripRating,
              onSelectRating: (rate) {
                setState(() {
                  tripRating = rate;
                });
              },
            ),
            const SizedBox(height: 8),
            Text(
              AppStrings.driverRate.tr(),
              style: getMediumStyle(
                  color: ColorManager.primaryTextColor, fontSize: 16),
            ),
            CustomRatingWidget(
              intialRating: driverRating,
              onSelectRating: (rate) {
                setState(() {
                  driverRating = rate;
                });
              },
            ),
            const SizedBox(height: 16),
            state is RatingTripIsLoading
                ? const CustomCircularProgressIndicator()
                : CustomTextButton(
                    text: AppStrings.confirm.tr(),
                    showIcon: false,
                    onPressed: (driverRating != 0 && tripRating != 0)
                        ? () {
                            BlocProvider.of<TripDetailsBloc>(context).add(
                              RateTrip(
                                tripId: widget.tripDetails.tripId!,
                                driverRating: driverRating,
                                tripRating: tripRating,
                              ),
                            );
                          }
                        : null,
                  )
          ],
        );
      },
    );
  }
}
