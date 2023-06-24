import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/water_tank/views/widgets/water_dropdown_view.dart';

import '../../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../../common/widgets/custom_text_button.dart';
import '../../../../transport_request_viewmodel.dart';
import '../models/water_model.dart';

class WaterFirstView extends StatefulWidget {
  final WaterModel waterModel;
  final TransportRequestViewModel viewModel;

  const WaterFirstView({
    Key? key,
    required this.waterModel,
    required this.viewModel,
  }) : super(key: key);

  @override
  State<WaterFirstView> createState() => _WaterFirstViewState();
}

class _WaterFirstViewState extends State<WaterFirstView> {
  @override
  void initState() {
    widget.viewModel.waterTankViewModel.start(widget.waterModel);
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
                WaterDropdownView(
                  waterTankViewModel: widget.viewModel.waterTankViewModel,
                ),
                const SizedBox(height: 64),
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
                    widget.viewModel.waterTankViewModel.firstScreenValid,
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
