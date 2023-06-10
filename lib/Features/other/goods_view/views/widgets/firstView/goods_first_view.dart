import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/other/goods_view/views/goods_viewmodel.dart';
import 'package:taxi_for_you/Features/other/goods_view/views/widgets/firstView/widgets/first_view_booleans.dart';

import '../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../common/widgets/custom_text_button.dart';

class GoodsFirstView extends StatefulWidget {
  final GoodsViewModel goodsViewModel;

  const GoodsFirstView({Key? key, required this.goodsViewModel})
      : super(key: key);
  @override
  _GoodsFirstViewState createState() => _GoodsFirstViewState();
}

class _GoodsFirstViewState extends State<GoodsFirstView> {
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
                GoodsFirstViewBooleans(
                  viewModel: widget.goodsViewModel,
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
              child: CustomTextButton(
                  text: AppStrings.next.tr(),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    setState(() {
                      widget.goodsViewModel.handleSteps();
                    });
                  })),
        ),
      ],
    );
  }
}
