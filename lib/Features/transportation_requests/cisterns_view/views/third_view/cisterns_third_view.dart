import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/constants.dart';
import '../../../../../core/utils/resources/color_manager.dart';
import '../../../../../core/utils/resources/strings_manager.dart';
import '../../../../common/widgets/custom_text_button.dart';
import '../../../common/common_bloc/transportation_bloc.dart';
import '../../../common/common_bloc/transportation_event.dart';
import '../../../common/common_views/pageview_widgets/third_view_widget/third_view_widget.dart';
import '../cisterns_viewmodel.dart';

class CisternsThirdView extends StatefulWidget {
  final CisternsViewModel cisternsViewModel;
  const CisternsThirdView({
    Key? key,
    required this.cisternsViewModel,
  }) : super(key: key);

  @override
  State<CisternsThirdView> createState() => _CisternsThirdViewState();
}

class _CisternsThirdViewState extends State<CisternsThirdView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ThirdViewWidget(
          notes: widget.cisternsViewModel.cisternsModel.notes,
          amount: widget.cisternsViewModel.cisternsModel.paymentValue,
          onNotesChanged: (notes) {
            if (notes != '') {
              widget.cisternsViewModel.cisternsModel.notes = notes;
            } else {
              widget.cisternsViewModel.cisternsModel.notes = null;
            }
          },
          onAmountChanged: (amount) {
            if (amount != null && amount != '') {
              widget.cisternsViewModel.cisternsModel.paymentValue =
                  int.parse(amount);
              widget.cisternsViewModel.thirdScreenValid.value = true;
            } else {
              widget.cisternsViewModel.cisternsModel.paymentValue = null;
              widget.cisternsViewModel.thirdScreenValid.value = false;
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
                valueListenable: widget.cisternsViewModel.thirdScreenValid,
                builder: (BuildContext context, bool value, _) {
                  return CustomTextButton(
                      text: AppStrings.sendRequest.tr(),
                      onPressed: value
                          ? () {
                              FocusScope.of(context).unfocus();
                              inspect(widget.cisternsViewModel.cisternsModel);
                              BlocProvider.of<TransportationBloc>(context).add(
                                SendTransportationRequest(
                                  endPoint:
                                      EndPointsConstants.sendCisternsRequest,
                                  body: widget.cisternsViewModel.cisternsModel
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
