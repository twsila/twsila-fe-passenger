import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/furniture/models/furniture_model.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/furniture/view/widgets/first_view_booleans.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/furniture/view/widgets/first_view_numbers.dart';
import '../../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../../common/widgets/custom_text_button.dart';
import '../../../../transport_request_viewmodel.dart';

class FurnitureFirstView extends StatefulWidget {
  final FurnitureModel furnitureModel;
  final TransportRequestViewModel viewModel;

  const FurnitureFirstView({
    Key? key,
    required this.furnitureModel,
    required this.viewModel,
  }) : super(key: key);
  @override
  _FurnitureFirstViewState createState() => _FurnitureFirstViewState();
}

class _FurnitureFirstViewState extends State<FurnitureFirstView> {
  @override
  void initState() {
    widget.viewModel.furnitureViewModel.start(widget.furnitureModel);
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
                FurnitureFirstViewNumbersWidget(
                  viewModel: widget.viewModel.furnitureViewModel,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  child: const Divider(),
                ),
                FurnitureFirstViewBooleans(
                  furnitureModel: widget.furnitureModel,
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
                    widget.viewModel.furnitureViewModel.firstScreenValid,
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
