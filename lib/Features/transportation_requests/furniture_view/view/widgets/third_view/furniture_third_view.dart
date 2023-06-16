import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_for_you/Features/transportation_requests/common/common_bloc/transportation_bloc.dart';
import 'package:taxi_for_you/Features/transportation_requests/common/common_bloc/transportation_event.dart';
import 'package:taxi_for_you/Features/transportation_requests/common/common_views/pageview_widgets/third_view_widget/third_view_widget.dart';
import 'package:taxi_for_you/app/constants.dart';

import '../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../common/widgets/custom_text_button.dart';
import '../../furniture_viewmodel.dart';

class FurnitureThirdView extends StatefulWidget {
  final FurnitureViewModel furnitureViewModel;

  const FurnitureThirdView({
    Key? key,
    required this.furnitureViewModel,
  }) : super(key: key);

  @override
  _FurnitureThirdViewState createState() => _FurnitureThirdViewState();
}

class _FurnitureThirdViewState extends State<FurnitureThirdView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ThirdViewWidget(
          images: widget.furnitureViewModel.furnitureModel.images,
          notes: widget.furnitureViewModel.furnitureModel.notes,
          amount: widget.furnitureViewModel.furnitureModel.paymentValue,
          onNotesChanged: (notes) {
            if (notes != '') {
              widget.furnitureViewModel.furnitureModel.notes = notes;
            } else {
              widget.furnitureViewModel.furnitureModel.notes = null;
            }
          },
          onAmountChanged: (amount) {
            if (amount != null && amount != '') {
              widget.furnitureViewModel.furnitureModel.paymentValue =
                  int.parse(amount);
              widget.furnitureViewModel.thirdScreenValid.value = true;
            } else {
              widget.furnitureViewModel.furnitureModel.paymentValue = null;
              widget.furnitureViewModel.thirdScreenValid.value = false;
            }
          },
          onSelectImage: (images) {
            widget.furnitureViewModel.furnitureModel.images = images;
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
                valueListenable: widget.furnitureViewModel.thirdScreenValid,
                builder: (BuildContext context, bool value, _) {
                  return CustomTextButton(
                      text: AppStrings.sendRequest.tr(),
                      onPressed: value
                          ? () {
                              FocusScope.of(context).unfocus();
                              inspect(widget.furnitureViewModel.furnitureModel);
                              BlocProvider.of<TransportationBloc>(context).add(
                                SendTransportationRequest(
                                  endPoint:
                                      EndPointsConstants.sendFurnitureRequest,
                                  body: widget.furnitureViewModel.furnitureModel
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
