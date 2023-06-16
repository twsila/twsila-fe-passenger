import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_for_you/Features/other/car_aid_view/views/car_aid_viewmodel.dart';
import 'package:taxi_for_you/Features/other/common/common_bloc/transportation_bloc.dart';
import 'package:taxi_for_you/app/constants.dart';

import '../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../common/widgets/custom_text_button.dart';
import '../../../../common/common_bloc/transportation_event.dart';
import '../../../../common/common_views/pageview_widgets/third_view_widget/third_view_widget.dart';

class CarAidThirdView extends StatefulWidget {
  final CarAidViewModel carAidViewModel;

  const CarAidThirdView({
    Key? key,
    required this.carAidViewModel,
  }) : super(key: key);
  @override
  _CarAidThirdViewState createState() => _CarAidThirdViewState();
}

class _CarAidThirdViewState extends State<CarAidThirdView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ThirdViewWidget(
          notes: widget.carAidViewModel.carAidModel.notes,
          amount: widget.carAidViewModel.carAidModel.paymentValue,
          onNotesChanged: (notes) {
            if (notes != '') {
              widget.carAidViewModel.carAidModel.notes = notes;
            } else {
              widget.carAidViewModel.carAidModel.notes = null;
            }
          },
          onAmountChanged: (amount) {
            if (amount != null && amount != '') {
              widget.carAidViewModel.carAidModel.paymentValue =
                  int.parse(amount);
              widget.carAidViewModel.thirdScreenValid.value = true;
            } else {
              widget.carAidViewModel.carAidModel.paymentValue = null;
              widget.carAidViewModel.thirdScreenValid.value = false;
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
                valueListenable: widget.carAidViewModel.thirdScreenValid,
                builder: (BuildContext context, bool value, _) {
                  return CustomTextButton(
                      text: AppStrings.sendRequest.tr(),
                      onPressed: value
                          ? () {
                              FocusScope.of(context).unfocus();
                              inspect(widget.carAidViewModel.carAidModel);
                              BlocProvider.of<TransportationBloc>(context).add(
                                SendTransportationRequest(
                                  endPoint:
                                      EndPointsConstants.sendCarAidRequest,
                                  body: widget.carAidViewModel.carAidModel
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
