import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_for_you/Features/common/state_renderer/dialogs.dart';
import 'package:taxi_for_you/Features/trip_details/bloc/trip_details_bloc.dart';
import 'package:taxi_for_you/Features/trip_details/bloc/trip_details_event.dart';
import 'package:taxi_for_you/Features/trip_details/bloc/trip_details_state.dart';

import '../../../../core/utils/resources/color_manager.dart';
import '../../../../core/utils/resources/strings_manager.dart';
import '../../../common/widgets/custom_text_button.dart';

class CancelTripButton extends StatefulWidget {
  final int tripId;
  const CancelTripButton({Key? key, required this.tripId}) : super(key: key);

  @override
  State<CancelTripButton> createState() => _CancelTripButtonState();
}

class _CancelTripButtonState extends State<CancelTripButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: CustomTextButton(
        text: AppStrings.cancel.tr() + ' ' + AppStrings.request.tr(),
        showIcon: false,
        showShadow: false,
        hasBorder: true,
        color: ColorManager.white,
        textColor: ColorManager.primaryTextColor,
        onPressed: () {
          ShowDialogHelper.showDialogPopupWithCancel(
              AppStrings.confirmation.tr(),
              AppStrings.cancelTripConfirmation.tr(),
              context,
              () => Navigator.pop(context), () {
            BlocProvider.of<TripDetailsBloc>(context).add(
              CancelTripRequest(tripId: widget.tripId),
            );
            Navigator.pop(context);
          });
        },
      ),
    );
  }
}
