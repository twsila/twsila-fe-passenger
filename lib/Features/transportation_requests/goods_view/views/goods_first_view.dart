import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/transportation_requests/goods_view/models/goods_model.dart';
import 'package:taxi_for_you/Features/transportation_requests/goods_view/views/widgets/first_view_booleans.dart';
import 'package:taxi_for_you/Features/transportation_requests/goods_view/views/widgets/first_view_dropdowns.dart';

import '../../../../core/utils/resources/color_manager.dart';
import '../../../../core/utils/resources/strings_manager.dart';
import '../../../common/widgets/custom_counter_widget.dart';
import '../../../common/widgets/custom_text_button.dart';
import '../../common/common_views/transport_request_viewmodel.dart';

class GoodsFirstView extends StatefulWidget {
  final GoodsModel goodsModel;
  final TransportRequestViewModel viewModel;

  const GoodsFirstView({
    Key? key,
    required this.goodsModel,
    required this.viewModel,
  }) : super(key: key);
  @override
  _GoodsFirstViewState createState() => _GoodsFirstViewState();
}

class _GoodsFirstViewState extends State<GoodsFirstView> {
  @override
  void initState() {
    widget.viewModel.goodsViewModel.start(widget.goodsModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.fromLTRB(32, 16, 32, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GoodsDropdownsView(
                  goodsViewModel: widget.viewModel.goodsViewModel,
                ),
                const SizedBox(height: 16),
                CustomCounterWidget(
                  text: AppStrings.goodsSize.tr(),
                  value:
                      widget.viewModel.goodsViewModel.goodsModel.payloadWeight,
                  onPlusPressed: () {
                    setState(() {
                      widget.viewModel.goodsViewModel.goodsModel.payloadWeight =
                          (widget.viewModel.goodsViewModel.goodsModel
                                      .payloadWeight ??
                                  0) +
                              1;
                    });
                  },
                  onMinusPressed: () {
                    setState(() {
                      widget.viewModel.goodsViewModel.goodsModel.payloadWeight =
                          widget.viewModel.goodsViewModel.goodsModel
                                  .payloadWeight! -
                              1;
                    });
                  },
                ),
                Divider(color: ColorManager.grey),
                const SizedBox(height: 8),
                GoodsFirstViewBooleans(
                  goodsModel: widget.viewModel.goodsViewModel.goodsModel,
                ),
                const SizedBox(
                  height: 64,
                )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
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
                valueListenable:
                    widget.viewModel.goodsViewModel.firstScreenValid,
                builder: (BuildContext context, bool value, _) {
                  return CustomTextButton(
                      text: AppStrings.next.tr(),
                      onPressed: value
                          ? () {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                widget.viewModel.handleSteps();
                              });
                            }
                          : null);
                }),
          ),
        ),
      ],
    );
  }
}
