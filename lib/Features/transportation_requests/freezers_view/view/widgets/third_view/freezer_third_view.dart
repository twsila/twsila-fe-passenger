import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_for_you/Features/transportation_requests/common/common_bloc/transportation_bloc.dart';
import 'package:taxi_for_you/Features/transportation_requests/common/common_bloc/transportation_event.dart';
import 'package:taxi_for_you/Features/transportation_requests/freezers_view/view/freezers_viewmodel.dart';

import '../../../../../../app/constants.dart';
import '../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../common/widgets/custom_text_button.dart';
import '../../../../common/common_views/pageview_widgets/third_view_widget/third_view_widget.dart';

class FreezerThirdView extends StatefulWidget {
  final FreezersViewModel freezersViewModel;
  const FreezerThirdView({
    Key? key,
    required this.freezersViewModel,
  }) : super(key: key);

  @override
  State<FreezerThirdView> createState() => _FreezerThirdViewState();
}

class _FreezerThirdViewState extends State<FreezerThirdView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ThirdViewWidget(
          notes: widget.freezersViewModel.freezersModel.notes,
          amount: widget.freezersViewModel.freezersModel.paymentValue,
          onNotesChanged: (notes) {
            if (notes != '') {
              widget.freezersViewModel.freezersModel.notes = notes;
            } else {
              widget.freezersViewModel.freezersModel.notes = null;
            }
          },
          onAmountChanged: (amount) {
            if (amount != null && amount != '') {
              widget.freezersViewModel.freezersModel.paymentValue =
                  int.parse(amount);
              widget.freezersViewModel.thirdScreenValid.value = true;
            } else {
              widget.freezersViewModel.freezersModel.paymentValue = null;
              widget.freezersViewModel.thirdScreenValid.value = false;
            }
          },
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: ColorManager.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: const Offset(0, -7),
                )
              ],
            ),
            child: ValueListenableBuilder(
                valueListenable: widget.freezersViewModel.thirdScreenValid,
                builder: (BuildContext context, bool value, _) {
                  return CustomTextButton(
                      text: AppStrings.sendRequest.tr(),
                      onPressed: value
                          ? () {
                              FocusScope.of(context).unfocus();
                              inspect(widget.freezersViewModel.freezersModel);
                              BlocProvider.of<TransportationBloc>(context).add(
                                SendTransportationRequest(
                                  endPoint:
                                      EndPointsConstants.sendFreezersRequest,
                                  body: widget.freezersViewModel.freezersModel
                                      .toJson(),
                                ),
                              );
                            }
                          : null);
                }),
          ),
        ),
      ],
    );
  }
}
