import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/freezers/views/widgets/freezer_boolean_view.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/freezers/views/widgets/freezer_dropdowns_view.dart';

import '../../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../../common/widgets/custom_text_button.dart';
import '../../../../transport_request_viewmodel.dart';
import '../models/freezers-model.dart';

class FreezerFirstView extends StatefulWidget {
  final FreezersModel freezersModel;
  final TransportRequestViewModel viewModel;
  const FreezerFirstView({
    Key? key,
    required this.freezersModel,
    required this.viewModel,
  }) : super(key: key);

  @override
  State<FreezerFirstView> createState() => _FreezerFirstViewState();
}

class _FreezerFirstViewState extends State<FreezerFirstView> {
  @override
  void initState() {
    widget.viewModel.freezersViewModel.start(widget.freezersModel);
    widget.viewModel.freezersViewModel.validateFirstScreen();
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
                FreezerDropdownsView(
                  freezersViewModel: widget.viewModel.freezersViewModel,
                ),
                const SizedBox(height: 16),
                FreezerBooleanView(
                  freezersViewModel: widget.viewModel.freezersViewModel,
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
                    widget.viewModel.freezersViewModel.firstScreenValid,
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
