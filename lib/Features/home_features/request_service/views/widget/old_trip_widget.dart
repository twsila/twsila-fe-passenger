import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_for_you/Features/transportation_requests/model/transportation_base_model.dart';
import 'package:taxi_for_you/Features/trip_details/bloc/trip_details_bloc.dart';
import 'package:taxi_for_you/Features/trip_details/bloc/trip_details_event.dart';
import 'package:taxi_for_you/Features/trip_details/bloc/trip_details_state.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/di.dart';
import 'package:taxi_for_you/core/utils/helpers/trip_helper.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';

import '../../../../../app/constants.dart';
import '../../../../../core/utils/resources/assets_manager.dart';
import '../../../../../core/utils/resources/langauge_manager.dart';
import '../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../core/utils/resources/styles_manager.dart';
import '../../../../common/state_renderer/dialogs.dart';
import '../../../../common/widgets/custom_circular_indicator.dart';
import '../../../../transportation_requests/view/transport_request_view.dart';
import '../../bloc/draft_trip_bloc.dart';
import '../../bloc/draft_trip_event.dart';

class OldTripWidget extends StatefulWidget {
  final TransportationBaseModel draftTrip;
  const OldTripWidget({Key? key, required this.draftTrip}) : super(key: key);

  @override
  State<OldTripWidget> createState() => _OldTripWidgetState();
}

class _OldTripWidgetState extends State<OldTripWidget> {
  final AppPreferences appPreferences = instance<AppPreferences>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<TripDetailsBloc, TripDetailsStates>(
      listener: (context, state) {
        if (state is TripDetailsIsLoading) {
          setState(() {
            _isLoading = true;
          });
        } else {
          setState(() {
            _isLoading = false;
          });
          if (state is CancelTripSuccessfully) {
            BlocProvider.of<DraftTripBloc>(context).add(GetDraftTrip());
          } else if (state is CancelTripFailed) {
            ShowDialogHelper.showErrorMessage(
              state.baseResponse.errorMessage ??
                  AppStrings.somethingWentWrong.tr(),
              context,
            );
          }
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.continueRequest.tr(),
              textAlign: TextAlign.start,
              style: getBoldStyle(
                  color: ColorManager.primaryTextColor, fontSize: 18),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransportRequestScreen(
                        transportationBaseModel: widget.draftTrip,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    color: ColorManager.accentColor,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(ImageAssets.clock),
                          const SizedBox(width: 4),
                          Text(
                            TripHelper.getTripTitle(widget.draftTrip.tripType!),
                            style: getBoldStyle(
                                color: ColorManager.primaryTextColor,
                                fontSize: 12),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            appPreferences.getAppLanguage() ==
                                    LanguageType.ENGLISH.getValue()
                                ? Icons.arrow_back
                                : Icons.arrow_forward,
                            color: ColorManager.primary,
                            size: 16,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      _isLoading
                          ? const CustomCircularProgressIndicator(size: 24)
                          : GestureDetector(
                              onTap: () {
                                ShowDialogHelper.showDialogPopupWithCancel(
                                    AppStrings.confirmation.tr(),
                                    AppStrings.cancelRequestConfirmation.tr(),
                                    context,
                                    () => Navigator.pop(context), () {
                                  BlocProvider.of<TripDetailsBloc>(context).add(
                                      CancelTripRequest(
                                          tripId: widget.draftTrip.tripId!));
                                  Navigator.pop(context);
                                });
                              },
                              child: Text(
                                AppStrings.cancelRequest.tr(),
                                style: TextStyle(
                                    color: ColorManager.primaryTextColor,
                                    decoration: TextDecoration.underline),
                              ),
                            )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
