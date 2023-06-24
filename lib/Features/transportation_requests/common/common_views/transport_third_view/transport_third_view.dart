import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_for_you/Features/transportation_requests/common/common_bloc/transportation_bloc.dart';
import 'package:taxi_for_you/Features/transportation_requests/common/common_bloc/transportation_event.dart';
import 'package:taxi_for_you/Features/transportation_requests/common/common_views/transport_third_view/transport_third_viewmodel.dart';
import 'package:taxi_for_you/Features/transportation_requests/common/common_views/widgets/pageview_widgets/third_view_widget/third_view_widget.dart';
import 'package:taxi_for_you/Features/transportation_requests/furniture_view/models/furniture_model.dart';
import 'package:taxi_for_you/Features/transportation_requests/goods_view/models/goods_model.dart';
import 'package:taxi_for_you/app/constants.dart';

import '../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../common/widgets/custom_text_button.dart';
import '../../common_repo/transportation_base_model.dart';
import '../transport_request_viewmodel.dart';

class TransportThirdView extends StatefulWidget {
  final TransportationBaseModel transportationBaseModel;
  final TransportRequestViewModel viewModel;
  final bool hasImages;

  const TransportThirdView({
    Key? key,
    required this.transportationBaseModel,
    required this.viewModel,
    required this.hasImages,
  }) : super(key: key);

  @override
  _TransportThirdViewState createState() => _TransportThirdViewState();
}

class _TransportThirdViewState extends State<TransportThirdView> {
  TransportThirdViewModel viewModel = TransportThirdViewModel();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ThirdViewWidget(
          hasImages: widget.hasImages,
          images: widget.transportationBaseModel.images,
          notes: widget.transportationBaseModel.notes,
          amount: widget.transportationBaseModel.paymentValue,
          onNotesChanged: (notes) {
            if (notes != '') {
              widget.transportationBaseModel.notes = notes;
            } else {
              widget.transportationBaseModel.notes = null;
            }
          },
          onAmountChanged: (amount) {
            if (amount != null && amount != '') {
              widget.transportationBaseModel.paymentValue = int.parse(amount);
              widget.viewModel.thirdScreenValid.value = true;
            } else {
              widget.transportationBaseModel.paymentValue = null;
              widget.viewModel.thirdScreenValid.value = false;
            }
          },
          onSelectImage: (images) {
            widget.transportationBaseModel.images = images;
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
                valueListenable: widget.viewModel.thirdScreenValid,
                builder: (BuildContext context, bool value, _) {
                  return CustomTextButton(
                      text: AppStrings.sendRequest.tr(),
                      onPressed: value
                          ? () {
                              FocusScope.of(context).unfocus();
                              inspect(widget.transportationBaseModel);
                              viewModel
                                  .sendRequest(widget.transportationBaseModel);
                              BlocProvider.of<TransportationBloc>(context).add(
                                SendTransportationRequest(
                                  endPoint: viewModel.endPoint,
                                  files: widget.transportationBaseModel.images,
                                  body: viewModel.jsonBody,
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
