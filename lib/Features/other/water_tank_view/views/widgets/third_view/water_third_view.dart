import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../app/constants.dart';
import '../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../common/widgets/custom_text_button.dart';
import '../../../../common/common_bloc/transportation_bloc.dart';
import '../../../../common/common_bloc/transportation_event.dart';
import '../../../../common/common_views/pageview_widgets/third_view_widget/third_view_widget.dart';
import '../../water_viewmodel.dart';

class WaterThirdView extends StatefulWidget {
  final WaterTankViewModel waterTankViewModel;
  const WaterThirdView({
    Key? key,
    required this.waterTankViewModel,
  }) : super(key: key);

  @override
  State<WaterThirdView> createState() => _WaterThirdViewState();
}

class _WaterThirdViewState extends State<WaterThirdView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ThirdViewWidget(
          notes: widget.waterTankViewModel.waterModel.notes,
          amount: widget.waterTankViewModel.waterModel.paymentValue,
          onNotesChanged: (notes) {
            if (notes != '') {
              widget.waterTankViewModel.waterModel.notes = notes;
            } else {
              widget.waterTankViewModel.waterModel.notes = null;
            }
          },
          onAmountChanged: (amount) {
            if (amount != null && amount != '') {
              widget.waterTankViewModel.waterModel.paymentValue =
                  int.parse(amount);
              widget.waterTankViewModel.thirdScreenValid.value = true;
            } else {
              widget.waterTankViewModel.waterModel.paymentValue = null;
              widget.waterTankViewModel.thirdScreenValid.value = false;
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
                valueListenable: widget.waterTankViewModel.thirdScreenValid,
                builder: (BuildContext context, bool value, _) {
                  return CustomTextButton(
                      text: AppStrings.sendRequest.tr(),
                      onPressed: value
                          ? () {
                              FocusScope.of(context).unfocus();
                              inspect(widget.waterTankViewModel.waterModel);
                              BlocProvider.of<TransportationBloc>(context).add(
                                SendTransportationRequest(
                                  endPoint: EndPointsConstants.sendWaterRequest,
                                  body: widget.waterTankViewModel.waterModel
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
