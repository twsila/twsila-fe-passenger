import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_for_you/Features/other/goods_view/bloc/goods_bloc.dart';
import 'package:taxi_for_you/Features/other/goods_view/bloc/goods_event.dart';

import '../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../common/widgets/custom_text_button.dart';
import '../../../../common/pageview_widgets/third_view_widget/third_view_widget.dart';
import '../../goods_viewmodel.dart';

class GoodsThirdView extends StatefulWidget {
  final GoodsViewModel goodsViewModel;

  const GoodsThirdView({Key? key, required this.goodsViewModel})
      : super(key: key);
  @override
  _GoodsThirdViewState createState() => _GoodsThirdViewState();
}

class _GoodsThirdViewState extends State<GoodsThirdView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ThirdViewWidget(
            notes: widget.goodsViewModel.goodsModel.notes,
            amount: widget.goodsViewModel.goodsModel.paymentValue,
            onNotesChanged: (notes) {
              if (notes != '') {
                widget.goodsViewModel.goodsModel.notes = notes;
              } else {
                widget.goodsViewModel.goodsModel.notes = null;
              }
            },
            onAmountChanged: (amount) {
              if (amount != null && amount != '') {
                widget.goodsViewModel.goodsModel.paymentValue =
                    int.parse(amount);
                widget.goodsViewModel.thirdScreenValid.value = true;
              } else {
                widget.goodsViewModel.goodsModel.paymentValue = null;
                widget.goodsViewModel.thirdScreenValid.value = false;
              }
            }),
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
                valueListenable: widget.goodsViewModel.thirdScreenValid,
                builder: (BuildContext context, bool value, _) {
                  return CustomTextButton(
                      text: AppStrings.sendRequest.tr(),
                      onPressed: value
                          ? () {
                              FocusScope.of(context).unfocus();
                              inspect(widget.goodsViewModel.goodsModel);
                              BlocProvider.of<GoodsBloc>(context).add(
                                SendGoodsRequest(
                                  goodsModel: widget.goodsViewModel.goodsModel,
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
